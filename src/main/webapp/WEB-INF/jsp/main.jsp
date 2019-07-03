<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<style>
body {text-align:center;}
#searchResultTable tr:nth-of-type(odd) { 
    background: #eee; 
    }
#searchResultTable th { 
    background: #258fff; 
    color: white; 
    font-weight: bold; 
    }
#searchResultTable td, th { 
    padding: 10px; 
    border: 1px solid #ccc; 
    text-align: left; 
    font-size: 12px;
    }
 .pop{
  width:300px; height:400px; background:#fff;; 
  position:absolute; top:10px; left:100px; text-align:center; 
  border:2px solid #000;
  z-index:100;
   }
</style>
<meta charset="UTF-8">
<title>장소 검색 서비스</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
var page_size = 10; //페이지 사이즈(페이지 별 노출 개수)
var page_group_size = 5; //페이지 그룹 사이즈(한 페이지에 노출될 인덱스 개수)

$(document).ready(function() {
	$('#close1').click(function() {
        $('#pop1').hide();
      });
	$('#close2').click(function() {
        $('#pop2').hide();
      });

	//버튼 클릭 이벤트
	$('input[name="searchButton"]').click(function(){
		var searchText = $.trim($('input[name="searchText"]').val());
		if(!searchText) {
			alert('검색어를 입력해주세요.');
		}
		
		saveKeyword(searchText);
		
		goPage(1, searchText);
	});
});

//검색어 저장
function saveKeyword(keyword){
	$.post('/saveKeyword', 'keyword='+keyword);
}

//페이지 이동 및 검색
function goPage(page, keyword) {
	$('#map').hide();
	$.ajax({
		url: 'https://dapi.kakao.com/v2/local/search/keyword.json',
		data: 'query='+encodeURIComponent(keyword)+'&page='+page+'&size='+page_size,
		type: 'GET',
		dataType : 'json',
        beforeSend : function(xhr){
            xhr.setRequestHeader('Authorization', 'KakaoAK cce6c79bc037b293c6cffcce71e3b4f5');
            xhr.setRequestHeader('Content-type','application/x-www-form-urlencoded');
        },
        error: function(xhr, status, error){
            alert(error);
        },
		success: function(data) {
			var html = '';
			var meta = data.meta;
			
			$.each(data.documents, function(i, val) {
				html += '<tr>';
				html += '<td><a href="javascript:showMap('+val.x+','+val.y+',\''+val.place_name+'\',\''+val.address_name+'\');">'+val.place_name+'</a></td>';
				html += '<td>'+val.category_group_name+'</td>';
				html += '<td>'+val.address_name+'('+val.road_address_name+')'+'</td>';
				html += '<td>'+val.phone+'</td>';
				html += '<td><a href="javascript:window.open(\'https://map.kakao.com/link/map/'+val.id+'\');">상세보기</a></td>'
				html += '</tr>';
			});
			
			/*********** pagination start ************/
			var total_count = meta.total_count;
			var total_page = 1;
			
			if(total_count <= 0) {
				$('#searchResultTable').hide();
			} else {
				$('#searchResultTable').show();
			}
			
			if(total_count%page_size != 0) {
				total_page = total_count/page_size + 1;
			} else {
				total_page = total_count/page_size
			}
			
			$('#pageTr').empty();
			var page_group = parseInt(page/page_group_size);
			
			if(page%page_group_size==0) {
				page_group = page_group - 1;
			}
			
			if(page_group != 0) {
				$('#pageTr').append('<td><a href="javascript:goPage('+page_group*page_group_size+', \''+keyword+'\')">[이전]</a></td>');
			}
			for(var i = page_group*page_group_size+1; i <= (page_group+1)*page_group_size; i++) {
				if(i > total_page) break;

				if(i == page) {
					$('#pageTr').append('<td>'+i+'</td>');
				} else {
					$('#pageTr').append('<td><a href="javascript:goPage('+i+', \''+keyword+'\')">'+i+'</a></td>');
				}
				
				if(i == (page_group+1)*page_group_size) {
					$('#pageTr').append('<td><a href="javascript:goPage('+(i+1)+', \''+keyword+'\')">[다음]</a></td>');
				}
			}
			/*********** pagination end ************/
			
			$('#searchCount').html(numberWithCommas(total_count));
			
			$('#searchResult').empty();
			$('#searchResult').html(html);
		}
	});
}

//지도 표시
function showMap(x, y, place_name, address) {
	$('#map').show();
	
	var container = document.getElementById('map');
	var options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(y, x), //지도의 중심좌표.
			level: 3 //지도의 레벨(확대, 축소 정도)
		};
	var map = new kakao.maps.Map(container, options);
	
	var markerPosition  = new kakao.maps.LatLng(y, x);
	
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});
	
	marker.setMap(null);
	
	marker.setMap(map);
	
	var iwContent = '<div style="padding:5px;"><b>'+place_name+'</b><br>'+address+'</div>',
    iwPosition = new kakao.maps.LatLng(y, x);

	var infowindow = new kakao.maps.InfoWindow({
	    position : iwPosition, 
	    content : iwContent 
	});
	  
	infowindow.open(map, marker); 
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function popOpen(id) {
	$(id).show();
}
</script>
</head>
<body>
<div style="text-align:right; font-size:small;">
<a href="javascript:popOpen('#pop2');">최근 검색어</a>
<a href="javascript:popOpen('#pop1');">인기 검색어</a>
<a href="/logout">로그아웃</a>
</div>
<div>
	<h2>장소 검색 서비스</h2>
	<input type="text" name="searchText" placeholder="검색어를 입력해주세요.">
	<input type="button" name="searchButton" value="검색">
	<div id="pop1" class="pop">
		<div style="height:370px;">
			인기 검색어
		     <table>
					<tr>
						<th>순위</th>
						<th>키워드</th>
						<th>조회수</th>
					</tr>
					<c:forEach items="${hotKeywords}" var="k" varStatus="status">
					<tr>
						<td>${status.index+1}</td>
						<td><a href="javascript:goPage(1, '${k.keyword}');saveKeyword('${k.keyword}');">${k.keyword}</a></td>
						<td>${k.cnt}</td>
					</tr>
					</c:forEach>
				</table>
		</div>
		
		  <div>
		    <div id="close1" style="width:100px; margin:auto;">닫기</div>
		  </div>
	</div>
	<div id="pop2" class="pop">
		<div style="height:370px;overflow: scroll;">
			최근 검색어
			<table>
				<tr>
					<th>키워드</th>
					<th>조회일시</th>
				</tr>
				<c:forEach items="${histories}" var="h">
				<tr>
					<td><a href="javascript:goPage(1, '${h.keyword}');saveKeyword('${h.keyword}');">${h.keyword}</a></td>
					<td><fmt:formatDate value="${h.regDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
				</c:forEach>
			</table>
		</div>
		<div>
		    <div id="close2" style="width:100px; margin:auto;">닫기</div>
		</div>
	</div>
</div>
<div style="margin:10px;text-align:center;">
	<span style="font-size:12px;"> 검색결과 총 <font id="searchCount">0</font>건</span>
	<div style="margin:0 auto;width:100%">
		<div style="width:30%;float: left;box-sizing: border-box;">
			<div id="map" style="width:500px;height:400px;display:none;"></div>
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=322a30f99783c6b6163ddcad8eeaeabe"></script>
		</div>
		<div style="width:70%;float: right;box-sizing: border-box;">
			<table id="searchResultTable" style="margin:0 auto;display:none;">
				<thead>
					<tr>
						<th>장소명</th>
						<th>카테고리</th>
						<th>지번주소(도로명주소)</th>
						<th>전화번호</th>
						<th></th>
					</tr>
				</thead>
				<tbody id="searchResult">
				</tbody>
			</table>
			<table style="margin:0 auto;">
				<tr id="pageTr"></tr>
			</table>
		</div>
	</div>
</div>
</body>
</html>