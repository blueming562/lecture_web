<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="Model.Classes"%>
<%@ page import="Model.Course"%>
<%@ page import="Model.Department"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>과목 조회</title>
<style type="text/css">

/* 컨텐츠 */
.contents {
	padding: 25px 30px;
	overflow-x: auto;
	margin-left: 250px;
}

/* 폼 div */
.cols {
	align-items: center;
	display: flex;
	flex-wrap: wrap;
	width: 100%;
	gap: 3px;
}

.cols input, .cols select {
	flex: 1;
	/* 각 요소가 균등하게 공간을 차지하도록 함 */
	min-width: 0;
	/* 요소가 넘치지 않도록 최소 너비 설정 */
	padding: 5px;
	/* 내부 여백 */
	box-sizing: border-box;
	/* 패딩과 테두리를 포함한 크기 계산 */
}

.form-search {
	margin-bottom: 15px;
	padding: 12px;
	border: 1px solid #e6e6e6;
}

.form-search table {
	width: 100%;
	table-layout: fixed;
	border-spacing: 0;
}

.form-search table th, .form-search table td {
	border: 1px solid #ccc;
	text-align: center;
	font-size: 12px;
}

.form-search table input {
	width: 100%;
	height: 25px;
	font-size: 12px;
	border: 1px solid #ccc;
}

.form-search table select {
	width: 100%;
	height: 25px;
	font-size: 12px;
}

.search button {
	width: 30%;
}

.search button:first-child {
	background-color: #876243;
	color: white;
}

/* info-box */
.txt-red {
	color: red;
}

.txt-blue {
	color: blue;
}

.info-box {
	font-size: 13px;
	padding: 5px 25px;
	border: 1px solid #ccc;
}

.info-box ul li {
	padding: 3px 0;
}

/* table css */
.tcontainer {
	border-bottom: 3px solid #ccc;
	margin-top: 10px;
	height: 100%;
}

.tTable {
	border-collapse: collapse;
	width: 100%;
	text-align: center;
}

.tTable th, .tTable td {
	border: 1px solid #ccc;
}

.tTable th {
	font-size: 13px;
	border-top: 1px solid;
	background-color: beige;
}

.tTable td {
	font-size: 12px;
	height: 40px;
}

.tTable td:nth-child(4), .tTable td:nth-child(7) {
	text-align: left;
	padding: 4px 18px 4px 6px;
}

#lectureList {
	min-height: 200px;
	max-height: 500px;
}

.scrollable-body {
	overflow-y: auto;
	
}

.hWrap {
	margin-left: 250px;
}

.hWrap.all {
	margin-left: 0;
}

.contents.all {
	margin-left: 0;
}
</style>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>


	<%@ include file="/WEB-INF/views/sidebar.jsp"%>

	<div id="content">

		<div class="hWrap">
			<%@ include file="/WEB-INF/views/header.jsp"%>
		</div>

		<div class="contents">
			<div class="form-search">
				<form name="sForm" id="sForm" action="" method="post">
					<table>
						<colgroup>
							<col width="60px">
							<col width="80px">
							<col width="80px">
							<col width="80px">
							<col width="80px">
							<col width="220px">
							<col width="80px">
							<col width="120px">
							<col>
						</colgroup>
						<tr>
							<td colspan="2">
								<div class="cols">
									<input type="text" name="pYear" id="pYear" value="2024"
										maxlength="4"> <select name="pTrem" id="pTerm">
										<option value="">1학기</option>
										<option value="">여름계절</option>
										<option value="" selected>2학기</option>
										<option value="">겨울계절</option>
									</select>
								</div>
							</td>
							<th>캠퍼스</th>
							<td><select name="pCampus" id="pCampus">
									<option value="" selected>서울</option>
									<option value="">세종</option>
							</select></td>
							<th>대학구분</th>
							<td><select name="pGradCd" id="pGradCd">
									<option value="">대학</option>
									<option value="">대학원</option>
							</select></td>
							<th class="isu">이수구분</th>
							<td class="isu" colspan="2">
								<div class="cols">
									<select id="departmentFilter" name="department">
										<option value="">전체</option>
										<%
										//학과 id,name으로 매핑되어 있는 departmentMap 불러움 
										Map<Integer, String> departmentsMap = (Map<Integer, String>) request.getAttribute("departmentsMap");
										if (departmentsMap != null) {
											for (Map.Entry<Integer, String> entry : departmentsMap.entrySet()) {
										%>
										<option value="<%=entry.getValue()%>"><%=entry.getValue()%></option>
										<%
										}
										}
										%>
									</select> <select id="classificationFilter" name="classification">
										<option value="">전체</option>
										<option value="전공필수">전공필수</option>
										<option value="전공선택">전공선택</option>
										<option value="교양">교양</option>
									</select>

									<!-- <select name="pGroupCd" id="pGroupCd"></select> -->
								</div>
							</td>
						</tr>
						<tr>
							<th>학점</th>
							<td><input type="text" name="" id=""></td>
							<th>요일</th>
							<td><select name="" id="">
									<option value="">전체</option>
							</select></td>
							<th>교시</th>
							<td>
								<div class="cols">
									<select name="" id="">
										<option value="">전체</option>
									</select> <span class="unit">~</span> <select name="" id="">
										<option value="">전체</option>
									</select>
									<button type="button">교시 확인표</button>
								</div>
							</td>
							<th>담당교수</th>
							<td><input type="text" name="" id=""></td>
						</tr>
						<tr>
							<th>학수번호</th>
							<td><input type="text" name="" id=""></td>
							<th>분반</th>
							<td><input type="text" name="" id=""></td>
							<th>교과목명</th>
							<td colspan="3"><input type="text" name="" id=""></td>
							<td class="search">
								<button type="button" id="filterButton">조회</button>
								<button type="button">초기화</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="info-box">
				<ul>
					<li><span class="txt-red">학수번호, 교과목명, 대학원</span> 검색시 <span
						class="txt-blue">이수구분 조건은 무시</span>됩니다</li>
					<li><span class="txt-red">M</span>: MOOC <span class="txt-red">FC</span>:
						Flipped Class <span class="txt-red">T</span>: Tutorial <span
						class="txt-red">NM</span>: NeMo Class <span class="txt-red">SC</span>:
						Signature Class(영강100선) <span class="txt-red">DL</span>: DROP
						LIMIT(수강포기제한) <br> <span class="txt-blue">과목명에 뒤에
							아이콘으로 표기됩니다.</span></li>
					<li>학수번호 클릭시 강의계획안 조회가 가능합니다.</li>
					<li>강의계획안 학생의견 작성 안내 : 포털 로그인->수업->수강안내->학부 전공과목/교양교직과목 내에서 해당
						과목 학수번호 클릭 후 강의계획서 조회하여 조회되는 강의계획서 하단에 의견 작성 가능</li>
				</ul>
			</div>
			<div class="tcontainer">
				<div class="tWrap">
					<table class="tTable">
						<thead>
							<tr>
								<th style="width: 11%;">학수번호</th>
								<th style="width: 11%;">이수구분</th>
								<th style="width: 12%;">개설학과</th>
								<th style="width: 22%;">교과목명</th>
								<th style="width: 12%;">담당교수</th>
								<th style="width: 9%;">학점 <br> (시간)
								</th>
								<th style="width: 17%;">강의실</th>
								<th style="width: 11%;">강의시간</th>
							</tr>
						</thead>
					</table>
				</div>
				<div class="tWrap scrollable-body" id="lectureList">
					<table class="tTable" id="courseTable">
						<tbody>
							<%
                    List<Classes> allClasses = (List<Classes>) request.getAttribute("allClasses");
                    Map<Integer, Integer> enrolledCourses = (Map<Integer, Integer>) request.getAttribute("enrolledCourses");

                    if (allClasses != null && !allClasses.isEmpty()) {
                        for (Classes classEntity : allClasses) {
                            int courseId = classEntity.getCourseId();
                            int classId = classEntity.getClassId();
                %>
                <tr>
                    
                    <td style="width: 11%;"><%=courseId%></td>
                    <td style="width: 11%;"><%=classEntity.getClassification()%></td>
                    <td style="width: 12%;"><%=classEntity.getDepartmentName()%></td>
                    <td style="width: 22%;"><%=classEntity.getCourseName()%></td>
                    <td style="width: 12%;"><%=classEntity.getProfessorName()%> 교수</td>
                    <td style="width: 9%;"><%=classEntity.getCredit()%></td>
                    <td style="width: 17%;"><%=classEntity.getRoomNo()%></td>
                    <td style="width: 11%;"><%=classEntity.getDayOfWeek()%> <%=classEntity.getStartTime()%> ~ <%=classEntity.getEndTime()%></td>
                    
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="13">조회된 강의가 없습니다.</td>
                </tr>
                <%
                    }
                %>
						</tbody>
					</table>
				</div>
			</div>
		</div>


	</div>
</body>

<script type="text/javascript">
	const scrollableBody = document.querySelector('.scrollable-body');

	function adjustWidth() {
		const bodyHeight = scrollableBody.scrollHeight;
		if (bodyHeight > 500) {
			scrollableBody.style.width = 'calc(100% + 16px)';
		} else {
			scrollableBody.style.width = '100%';
		}
	}

	// 페이지 로드 시 조정
	adjustWidth();

	// 창 크기 변경 시 다시 조정
	window.addEventListener('resize', adjustWidth);
</script>
<script>
	$(document)
			.ready(
					function() {
						// 필터링 버튼 클릭 시
						$("#filterButton")
								.click(
										function() {
											//필터의 value 가져옴
											var selectedDepartment = $(
													"#departmentFilter").val();
											var selectedClassification = $(
													"#classificationFilter")
													.val();

											// "강의 목록" 테이블의 행만 필터링
											$("#courseTable tbody tr")
													.each(
															function() {
																var deptCell = $(
																		this)
																		.find(
																				"td:nth-child(3)")
																		.text(); // 3번째 컬럼: 학과 이름
																var classCell = $(
																		this)
																		.find(
																				"td:nth-child(2)")
																		.text(); // 4번째 컬럼: 분류

																var showRow = true;

																//선택된 학과의 값과 4번째 컬럼(학과이름)의 값이 다르거나
																if (selectedDepartment
																		&& deptCell !== selectedDepartment) {
																	showRow = false;
																}

																//선택된 분류의 값과 5번째 컬럼(분류)의 값이 다르면 return false;
																if (selectedClassification
																		&& classCell !== selectedClassification) {
																	showRow = false;
																}

																//showRow가 true면 출력 false면 제거
																if (showRow) {
																	$(this)
																			.show();
																} else {
																	$(this)
																			.hide();
																}
															});
											adjustWidth();
										});
					});
	function toggleSidebar() {
		const wrapper = document.querySelector(".wrapper");
		const menuControl = document.querySelector(".menu-control");
		const content = document.getElementById("content"); // 메인 콘텐츠 영역 선택

		const contents = document.querySelector(".contents");
		const hWrap = document.querySelector(".hWrap");

		contents.classList.toggle(".all");
		hWrap.classList.toggle(".all");

		wrapper.classList.toggle("hide"); // 사이드바 표시/숨김 토글
		content.classList.toggle("sidebar-collapsed"); // 메인 콘텐츠 영역에 클래스 토글

		if (wrapper.classList.contains("hide")) {
			menuControl.textContent = "▶"; // 사이드바 닫힘 상태
		} else {
			menuControl.textContent = "◀"; // 사이드바 열림 상태
		}
	}
</script>
</html>
