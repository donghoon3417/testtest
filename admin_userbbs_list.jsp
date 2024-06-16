<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="../include/admin_header.jsp" />
<%-- ../는 한단계 상위폴더로 이동하라는 상대경로.  ./는 현재경로. ../../ 두단계 상위폴더로 이동 --%>

<%--관리자 메인 본문 --%>
<div id="aMain_cont">
	<form method="get" action="admin_userbbs_list">
		<div id="bList_wrap">
			<h2 class="bList_title">관리자 상품문의</h2>
			<div class="bList_count">글개수: ${totalCount} 개</div>
			<table id="bList_t">
				<tr>
					<th width="10%" height="26">번호</th>
					<th width="10%">등급</th>
					<th width="10%">아이디</th>
					<th width="10%">4구 수지</th>
					<th width="10%">3구 평점</th>
					<th width="10%">나이</th>
					<th width="10%">지역</th>
					<th width="10%">당구장</th>
					<th width="10%">작성일</th>
					<th width="10%">수정/삭제</th>
				</tr>
				<tbody>
					<c:if test="${!empty blist}">
						<!-- 내림차순 글번호를 설정하기 위한 초기 변수 -->
						<c:set var="seq_no" value="${startNumber}" />

						<c:forEach var="b" items="${blist}">
							<!-- 원본글만 표시 -->
							<c:if test="${b.userbbs_step == 0}">
								<tr>
									<td align="center">${seq_no}</td>
									
									<td align="center">
										<!-- 제목과 일치하는 이미지 표시 --> <c:choose>
											<c:when test="${not empty titleImageMap[b.userbbs_title]}">
												<img
													src="${pageContext.request.contextPath}${titleImageMap[b.userbbs_title]}"
													alt="제목 이미지" style="width: 30px; height: 30px;">
											</c:when>
											<c:otherwise>
                            파일이 없습니다.
                        </c:otherwise>
										</c:choose>
									</td>
									<td align="center">${b.userbbs_id}</td>
									<td align="center"><a
										href="userbbs_cont?userbbs_no=${b.userbbs_no}&state=cont&page=${page}">
											${b.userbbs_title} </a></td>
										<td align="center">${b.userbbs_cont}</td>
									<td align="center">${b.userbbs_old}</td>
									<td align="center">${b.userbbs_area}</td>
									<<td align="center">${b.userbbs_bil}</td>
									<td align="center">${fn:substring(b.userbbs_date, 0, 10)}</td>
									<td align="center" style="padding-left: 20px;"><input
										type="button" value="수정"
										onclick="location='userbbs_cont?userbbs_no=${b.userbbs_no}&page=${page}&state=edit';" />
										<input type="button" value="삭제"
										onclick="location='userbbs_cont?userbbs_no=${b.userbbs_no}&page=${page}&state=del';" />
									</td>
								</tr>
								<c:set var="seq_no" value="${seq_no - 1}" />
							</c:if>
						</c:forEach>
					</c:if>
				</tbody>

				<c:if test="${empty blist}">
					<tr>
						<th colspan="5">목록이 없습니다!</th>
					</tr>
				</c:if>
			</table>

			<%-- 페이징 --%>
			<div id="bList_paging">
				<%-- 검색전 페이징 --%>
				<c:if test="${(empty find_field) && (empty find_name)}">
					<c:if test="${page <= 1}">[이전]&nbsp;</c:if>
					<c:if test="${page > 1}">
						<a href="admin_userbbs_list?page=${page - 1}">[이전]</a>&nbsp;
                    </c:if>
					<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
						<c:if test="${a == page}"><${a}></c:if>
						<c:if test="${a != page}">
							<a href="admin_userbbs_list?page=${a}">[${a}]</a>&nbsp;
                        </c:if>
					</c:forEach>
					<c:if test="${page >= maxpage}">[다음]</c:if>
					<c:if test="${page < maxpage}">
						<a href="admin_userbbs_list?page=${page + 1}">[다음]</a>
					</c:if>
				</c:if>

				<%-- 검색후 페이징 --%>
				<c:if test="${(!empty find_field) || (!empty find_name)}">
					<c:if test="${page <= 1}">[이전]&nbsp;</c:if>
					<c:if test="${page > 1}">
						<a href="admin_userbbs_list?page=${page - 1}&find_field=${find_field}&find_name=${find_name}">[이전]</a>&nbsp;
                    </c:if>
					<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
						<c:if test="${a == page}"><${a}></c:if>
						<c:if test="${a != page}">
							<a href="admin_userbbs_list?page=${a}&find_field=${find_field}&find_name=${find_name}">[${a}]</a>&nbsp;
                        </c:if>
					</c:forEach>
					<c:if test="${page >= maxpage}">[다음]</c:if>
					<c:if test="${page < maxpage}">
						<a href="admin_userbbs_list?page=${page + 1}&find_field=${find_field}&find_name=${find_name}">[다음]</a>
					</c:if>
				</c:if>
			</div>

			<div id="bList_menu">
				<input type="button" value="작성하기"
					onclick="location='userbbs_write?page=${page}';" />
				<c:if test="${(!empty find_field) && (!empty find_name)}">
					<input type="button" value="전체목록"
						onclick="location='admin_userbbs_list?page=${page}';" />
				</c:if>
			</div>

			<%-- 검색 폼 추가 --%>
			<div id="bFind_wrap">
				<select name="find_field">
					<option value="userbbs_title"
						<c:if test="${find_field == 'userbbs_title'}">selected</c:if>>제목</option>
					<option value="userbbs_cont"
						<c:if test="${find_field == 'userbbs_cont'}">selected</c:if>>내용</option>
				</select> <input name="find_name" id="find_name" size="14"
					value="${find_name}" /> <input type="submit" value="검색" />
			</div>
		</div>
	</form>
</div>

<jsp:include page="../include/admin_footer.jsp" />
