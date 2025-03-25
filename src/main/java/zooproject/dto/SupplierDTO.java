package zooproject.dto;

import org.springframework.stereotype.Component;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

@Component
public class SupplierDTO extends AbstractDTO<SupplierDTO>{
    private Long supplierId;

    @NotBlank(message = "Trường này không được để trống")
    private String supplierName;

    @NotBlank(message = "Trường này không được để trống")
    private String supplierPhone;

    @NotBlank(message = "Trường này không được để trống")
    @Email(message = "Trường này phải là email")
    private String supplierEmail;

    @NotBlank(message = "Trường này không được để trống")
    private String supplierAddress;

    @NotBlank(message = "Trường này không được để trống")
    private String supplierDesc;
    
    public SupplierDTO () {
    	super();
    }

    public SupplierDTO(Long supplierId, String supplierName, String supplierPhone, String supplierEmail, String supplierAddress, String supplierDesc) {
        this.supplierId = supplierId;
        this.supplierName = supplierName;
        this.supplierPhone = supplierPhone;
        this.supplierEmail = supplierEmail;
        this.supplierAddress = supplierAddress;
        this.supplierDesc = supplierDesc;
    }

    public long getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(Long supplierId) {
        this.supplierId = supplierId;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getSupplierPhone() {
        return supplierPhone;
    }

    public void setSupplierPhone(String supplierPhone) {
        this.supplierPhone = supplierPhone;
    }

    public String getSupplierEmail() {
        return supplierEmail;
    }

    public void setSupplierEmail(String supplierEmail) {
        this.supplierEmail = supplierEmail;
    }

    public String getSupplierAddress() {
        return supplierAddress;
    }

    public void setSupplierAddress(String supplierAddress) {
        this.supplierAddress = supplierAddress;
    }

    public String getSupplierDesc() {
        return supplierDesc;
    }

    public void setSupplierDesc(String supplierDesc) {
        this.supplierDesc = supplierDesc;
    }
}

