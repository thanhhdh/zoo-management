package zooproject.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final CustomUserDetailsService customUserDetailsService;

    @Autowired
    public SecurityConfig(CustomUserDetailsService customUserDetailsService) {
        this.customUserDetailsService = customUserDetailsService;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
    
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable()
            .authorizeRequests()
                .antMatchers("/auth/login", "/auth/register", "/auth/**","/template/**").permitAll()  // Cho phép truy cập /auth/login mà không cần xác thực
                .antMatchers("/admin/**").authenticated()
                .anyRequest().permitAll()  // Yêu cầu xác thực đối với các yêu cầu khác
            .and()
            .sessionManagement()
                .sessionFixation().migrateSession()  // Đảm bảo phiên đăng nhập không bị tấn công bằng cách di chuyển session
                .invalidSessionUrl("/auth/login?timeout=true")  // URL chuyển hướng khi phiên đăng nhập hết hạn
                .maximumSessions(1)  // Số lượng phiên đăng nhập tối đa cho mỗi người dùng (1 đồng nghĩa với không cho phép đăng nhập đa phiên)
                .maxSessionsPreventsLogin(true)  // Ngăn không cho đăng nhập khi đã đạt số lượng phiên đăng nhập tối đa
                .expiredUrl("/auth/login?expired=true")  // URL chuyển hướng khi phiên đăng nhập đã hết hạn
            .and()
            .and()
            .formLogin()
                .loginPage("/auth/login")  // Trang đăng nhập tùy chỉnh
                .loginProcessingUrl("/auth/login")  // URL để gửi biểu mẫu đăng nhập
                .defaultSuccessUrl("/admin/dashboard", true)  // URL chuyển hướng sau khi đăng nhập thành công
                .failureUrl("/auth/login?error=true")  // URL chuyển hướng sau khi đăng nhập thất bại
                .permitAll()
            .and()
            .logout()
                .logoutUrl("/auth/logout")  // URL đăng xuất
                .logoutSuccessUrl("/auth/login?logout=true")  // URL chuyển hướng sau khi đăng xuất thành công
                .invalidateHttpSession(true)  // Hủy phiên hiện tại
                .deleteCookies("JSESSIONID")  // Xóa cookie JSESSIONID
                .permitAll()
            .and()
            .exceptionHandling()
                .accessDeniedPage("/access-denied"); // Điều hướng đến trang access denied khi không có quyền truy cập
        		
    }
    
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(customUserDetailsService).passwordEncoder(passwordEncoder());
    }
}
