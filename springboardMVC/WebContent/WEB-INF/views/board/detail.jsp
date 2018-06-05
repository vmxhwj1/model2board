<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상세보기</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

</head>
<body>
	<%@ include file="../include/header.jsp"%>
	<section class="content">
		<div class="box">
			<div class="box-header">
				<h3 class="box-title">상세보기</h3>
			</div>

			<div class="box-body">
				<div class="form-group">
					<label>제목</label> <input type="text" name="title"
						class="form-control" value="${vo.title}" readonly="readonly" />
				</div>

				<div class="form-group">
					<label>내용</label>
					<textarea name="content" rows="5" readonly="readonly"
						class="form-control">${vo.content}</textarea>
				</div>

				<div class="form-group">
					<label>작성자</label> <input type="text" class="form-control"
						value="${vo.nickname}" readonly="readonly" />
				</div>
			</div>
			<div class="box-footer">
				<button class="btn btn-success" id="mainbtn">&nbsp;메&nbsp;인&nbsp;</button>
				<c:if test="${user.email == vo.email}">
					<button class="btn btn-warning" id="updatebtn">수정</button>
					<button class="btn btn-danger" id="deletebtn">삭제</button>
				</c:if>
				<button class="btn btn-primary" id="listbtn">목록</button>
				<button class="btn btn-info" id="replyadd">댓글작성</button>
				
				<!-- 댓글이 있는 경우에만 버튼을 출력 -->
				<c:if test="${vo.replycnt > 0}">
					<button class="btn btn-default" id="replylist">
					댓글읽기</button>
				</c:if>
				
			</div>
		</div>
	</section>
	
	<!-- 댓글 출력 영역 -->
	<div id="replydisp"></div>
	
	
	<!-- 댓글 작성 및 수정 대화상자 영역 -->
	<div class="box-body" style="display:none" id="replyform">
		<label for="nickname">작성자</label>
		<input class="form-control" type="text" id="nickname"
		value="${user.nickname}" readonly="readonly" />
		<label for="replytext">댓글내용</label>
		<input type="text" class="form-control" id="replytext"
		placeholder="댓글 내용을 작성하세요!" />
	</div>
	
	
	<%@ include file="../include/footer.jsp"%>
	<script>
	//댓글 삭제를 눌렀을 때 호출될 함수
	function del(btn){
		//댓글 번호 가져오기
		id = btn.id;
		//댓글번호 만들기 - 앞의 3글자 제외한 부분
		rno = id.substr(3);
		//삭제를 위한 대화상자를 출력
		$('#dialog-confirm').dialog({
			resizable:false,
			height:'auto',
			width:400,
			modal:true,
			buttons:{
				"삭제":function(){
					$(this).dialog("close");
					
					$.ajax({
						url:"../reply/delete",
						data:{"rno": rno},
						dataType:"json",
						success:function(data){
							getReply();
						}
					});
					
				},
				"취소":function(){
					$(this).dialog("close");
				}
			}
		});
	}
	
	//접속한 유저의 이메일을 자바스크립트에서 사용할 수 있도록 변수에 저장
	email = "${user.email}";
	
	//댓글 읽기 버튼을 눌렀을 때의 동작
	<c:if test="${vo.replycnt > 0}">
		document.getElementById("replylist").addEventListener(
			"click", function(){
			
			//함수를 호출
			//댓글 저장이나 수정 및 삭제 후에도 호출할 것이므로
			//별도의 함수로 만드는 것이 코딩양을 줄이기 때문입니다.
			getReply();
				
		});
	</c:if>
	
	//댓글 목록을 가져오는 함수
	function getReply(){
		//댓글 목록을 가져오는 ajax 요청
		$.ajax({
			url:"../reply/list",
			data:{"bno":'${vo.bno}'},
			dataType:"json",
			success:function(data){
				//출력하는 함수 호출
				//하나의 영역에서 코드가 너무 길어지면
				//알아보기 힘들기 때문에 코드를 분할
				display(data);
			}
		});
	}
	
	//댓글을 출력하는 함수
	function display(data){
		//출력 내용을 저장할 변수를 생성
		disp = '';
		//data 배열을 순회 - idx는 인덱스이고 item은 실제 내용
		$(data).each(function(idx, item){
			disp += "<div style='width:80%;height:50px'><label>";
			disp += item.nickname + ":" + item.replytext ;
			disp += "</label>";
			//접속한 유저와 댓글을 작성한 유저가 동일인이면
			if(email == item.email){
				//삭제 버튼을 생성
				//삭제 버튼이 여러 개 될 수 있는 경우 
				//버튼의 id를 구분할 수 있는 값으로 만들면
				//나중에 id를 가지고 구분할 수 있습니다.
				disp += "<button type='submit' class='btn btn-danger'";
				disp += " id='del" + item.rno + "' ";
				disp += "style='float:right' ";
				disp += "onclick = 'del(this)'>댓글삭제</button>";
				
				disp += "<button type='submit' class='btn btn-warning'";
				disp += " id='mod" + item.rno + "' ";
				disp += "style='float:right' ";
				disp += "onclick = 'mod(this)'>댓글수정</button>";
				
			}
			
			disp += "</div>";
		});
		//출력 영역에 출력
		document.getElementById("replydisp").innerHTML = disp;
	}
	
		//댓글 수정 버튼을 눌렀을 때 수행할 내용
		function mod(btn){
			id = btn.id;
			rno = id.substr(3);
			
			$('#replyform').dialog({
				resizable:false,
				height:'auto',
				width:400,
				model:true,
				buttons:{
					"수정":function(){
						$(this).dialog("close");
						//입력한 내용 가져오기
						replytext = document.getElementById("replytext").value;
						$.ajax({
							url:"../reply/update",
							data:{
								"replytext": replytext,
								"rno": rno
							},
							dataType:"json",
							success:function(data){
								//댓글을 출력하는 함수를 호출
								getReply();
							}
						});
					},
					"취소":function(){
						$(this).dialog("close");
					}
				}
			});
			
		}
	
		//댓글 작성 버튼을 눌렀을 때 수행할 내용
		document.getElementById("replyadd").addEventListener(
			"click", function(){
			$('#replyform').dialog({
				resizable:false,
				height:'auto',
				width:400,
				model:true,
				buttons:{
					"저장":function(){
						$(this).dialog("close");
						//입력한 내용 가져오기
						replytext = document.getElementById("replytext").value;
						$.ajax({
							url:"../reply/register",
							data:{
								"bno":'${vo.bno}',
								"email":'${user.email}',
								"nickname":'${user.nickname}',
								"replytext": replytext
							},
							dataType:"json",
							success:function(data){
								//댓글을 출력하는 함수를 호출
								getReply();
							}
						});
					},
					"취소":function(){
						$(this).dialog("close");
					}
				}
			});
		});
	
		//메인 버튼을 눌렀을 때 처리
		document.getElementById("mainbtn").addEventListener("click",
				function() {
					location.href = "../";
				});
		//목록 버튼을 눌렀을 때 처리
		document.getElementById("listbtn").addEventListener("click",
				function() {
					location.href = "list?page=${criteria.page}&perPageNum=${criteria.perPageNum}";
				});
		<c:if test = "${user.email == vo.email}">
		//수정 버튼을 눌렀을 때 처리
		document.getElementById("updatebtn").addEventListener("click",
				function() {
					location.href = "update?bno=" + ${vo.bno} +"&page=${criteria.page}&perPageNum=${criteria.perPageNum}";
				});
		</c:if>
	</script>

	
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

		<div id="dialog-confirm" title="정말로 삭제?" style="display: none">
			<p>삭제하시면 복구할 수 없습니다. 그래도 삭제하실 건가요?</p>
		</div>
	<!-- 로그인 한 유저와 작성자가 동일한 경우 -->
	<c:if test="${user.email == vo.email}">
		<script>
			//삭제 버튼을 눌렀을 때 처리
			document.getElementById("deletebtn").addEventListener(
					"click", function(){
						$("#dialog-confirm").dialog({
						      resizable: false,
						      height: "auto",
						      width: 400,
						      modal: true,
						      buttons: {
						        "삭제": function() {
						          $(this).dialog("close");
						          location.href="delete?bno=${vo.bno}" +"&page=${criteria.page}&perPageNum=${criteria.perPageNum}";
						        },
						        "취소": function() {
						          $(this).dialog("close");
						        }
						      }
						    });
						
			});
		</script>

	</c:if>