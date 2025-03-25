<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp"%>
<c:url var="urlImg" value="/template/web/img/animal/"></c:url>
<c:url var="urlImgSpecies" value="/template/web/img/species/"></c:url>

<html>
  <head>
    <title>Title</title>
    <style>

    </style>
  </head>
<body>

<div id="scrollTarget">
  <div class="animal-section text-center">
  </div>

  <section class="animal-categories py-5">
    <div class="container">
      <h2 class="text-center section-title mb-4">Danh Mục Các Loài</h2>
      <div class="row text-center">
      <c:forEach var="specie" items="${species}" varStatus="status">
        <div class="col-md-3">
          <div class="category-box">
            <img src="${urlImgSpecies}${specie.speciesImage}" alt="${specie.speciesName}" class="category-icon">
            <h5>${specie.speciesName}</h5>
          </div>
        </div>
      </c:forEach>
      </div>
    </div>
  </section>

  <section class="habitats py-5 bg-light">
    <div class="container">
      <h2 class="text-center section-title mb-4">Khu Vực Sinh Sống</h2>
      <div class="row g-4">
        <c:forEach var="area" items="${areas}" varStatus="status">
        <div class="col-md-4">
          <div class="habitat-box">
            <h4 class="mt-3">${area.areaName}</h4>
            <p>${area.areaDesc}</p>
          </div>
        </div>
        </c:forEach>
      </div>
    </div>
  </section>


  <!-- Information Section -->
  <section id="info-section" class="container py-5">
    <div class="text-center mb-5">
      <h2 class="fw-bold">Các loài động vật đa dạng</h2>
      <p class="text-muted">
        Khám phá bộ sưu tập khổng lồ của chúng tôi gồm hơn 1000 loài động vật khác nhau, bao gồm sư tử, hổ, ngựa vằn và nhiều loài khác.</p>
    </div>
  </section>

  <!-- Animal Cards Section -->
  <section id="animal-section" class="container py-5">
    <div class="row g-4">
      <c:if test="${not empty animals}">
        <c:forEach var="animal" items="${animals}">
          <div class="col-sm-6 col-md-4 col-lg-3">
            <div class="card animal-card h-100">
              <img src="${urlImg}${animal.animalImage}" class="card-img-top" alt="${animal.animalName}">
              <div class="card-body">
                <h5 class="card-title">${animal.animalName}</h5>
                <p class="card-text">Species: ${animal.species.speciesName}</p>
                <a href="/zooproject/animal/detail?animalId=${animal.animalId}" class="btn btn-outline-primary btn-sm">View Details</a>
              </div>
            </div>
          </div>
        </c:forEach>
      </c:if>
      <c:if test="${empty animals}">
        <p class="text-center">No animals available at the moment.</p>
      </c:if>
    </div>
  </section>

  <!-- Animal Details Accordion Section -->
  <section class="container py-5">
    <h3 class="text-center mb-4">Chi tiết động vật</h3>
    <div class="accordion" id="animalAccordion">
      <c:forEach var="animal" items="${animals}" varStatus="status">
        <div class="accordion-item">
          <h2 class="accordion-header" id="heading-${status.index}">
            <button class="accordion-button" type="button" data-bs-toggle="collapse"
                    data-bs-target="#collapse-${status.index}" aria-expanded="true" aria-controls="collapse-${status.index}">
                ${animal.animalName}
            </button>
          </h2>
          <div id="collapse-${status.index}" class="accordion-collapse collapse"
               aria-labelledby="heading-${status.index}" data-bs-parent="#animalAccordion">
            <div class="accordion-body">
              <div class="row">
                <div class="col-md-8">
                  <p><strong>Species:</strong> ${animal.species.speciesName}</p>
                  <p><strong>Cage:</strong> ${animal.cage.cageName}</p>
                  <p><strong>Food:</strong> ${animal.food.foodName}</p>
                  <p><strong>Age:</strong> ${animal.animalAge} years</p>
                  <p><strong>Description:</strong> ${animal.animalDesc}</p>
                </div>
                <div class="col-md-4">
                  <img src="${urlImg}${animal.animalImage}" class="img-fluid rounded" alt="${animal.animalName}">
                </div>
              </div>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </section>

</div>


  </body>
</html>
