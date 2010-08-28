<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sempedia | Making computers think about data the way we do</title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/jquery.autocomplete.css" type="text/css" />

<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.autocomplete.js"></script>
<script>
function findValue(li) {
	if( li == null ) return alert("No match!");
	if( !!li.extra ) var sValue = li.extra[0];
	else var sValue = li.selectValue;
}

function selectItem(li) {
	findValue(li);
}

function formatItem(row) {
	return row[0] + " (id: " + row[1] + ")";
}

function lookupAjax(){
	var oSuggest = $("#objectNameIdForAjax")[0].autocompleter;
	oSuggest.findValue();
	return false;
}



$(document).ready(function() {


	$("#objectNameIdForAjax").autocomplete(
		"jsp/getPredicateValues.jsp",
		{
			delay:1,
			minChars:1,
			matchSubset:1,
			matchContains:1,
			cacheLength:10,
			onItemSelect:selectItem,
			onFindValue:findValue,
			autoFill:true,
			maxItemsToShow:10
		}
	);
	
	
	
	
	
	getPredicates();
	getPredicatesIn();
	
	

});	
function getObjects(){
$(".predicate").click(
        	function() { 
        	
        	var pidicId=$(this).attr('id');
        	var mainObj=$(this);
        	$mainTd=$(this).closest('table').parent();
        	var sibs=$(this).closest('table').parent().prev().find('div').parent().siblings().length;
        	var subId=$(this).closest('table').parent().prev().find('div').parent().prev().prev().attr('id');
        	$(this).closest('table').find('img:first').parent().remove();
        	$(this).closest('table').parent().nextAll().remove();
        	var outht= "<td ><img src='images/right.jpg' width='16' height='10' alt='h' /></td>";
        	
			$(this).parent().append(outht);
        	
        	$.ajax({
   type: "POST",
   url: "triplePridicate.json",
   data: "subjectId="+ subId+"&predicateId="+pidicId,
   dataType: "json",
   cache: false,
   async: false,
    
   success: function(data){
   
 	 if(data.triplecount==0){
 	 var innHt="<td rowspan='2' valign='top' class='normal' ><table border='0' cellspacing='0' cellpadding='8'><tr><td>End Of Search</td></tr></table></td>";
     $mainTd.parent().append(innHt);
     
     }
     if(data.triplecount>0){
     
    var innHt="<td rowspan='2' valign='top' class='normal'><table border='0' cellspacing='0' cellpadding='8'>";
     $.each(data.objct,
         function(i,item) { 
         
            if(i+1==data.triplecount)
            
        innHt=innHt+"<tr><td class='object-search-in' id='"+data.objctId[i]+"'>"+item+"</td><td align='right' class='object-search-in-object'>"+
        "<a href='addObject.htm?action=getObjectDetailsFromSearch&objectName="+item+"&objectId="+data.objctId[i]+"'><img src='images/object-page.gif' alt='' width='16' height='16' /></a></td>"+
          "</tr></table></td>";
        else
        innHt=innHt+"<tr><td class='object-search-in' id='"+data.objctId[i]+"'>"+item+"</td><td align='right' class='object-search-in-object'>"+
        "<a href='addObject.htm?action=getObjectDetailsFromSearch&objectName="+item+"&objectId="+data.objctId[i]+"'><img src='images/object-page.gif' alt='' width='16' height='16' /></a></td>"+
          "</tr>";
        });
      
      
     $mainTd.parent().append(innHt);
   
   
    $('.object-search-in').bind('mouseover',function() {
     $(this).addClass("predicate-over");
      });
      
     $('.object-search-in').bind('mouseout',function() {
      $(this).removeClass("predicate-over");
      });
      
     $('.object-search-in').bind('click',getPredicatesIn())    ;
   
      
     } //end of if
   } //end of success
 });//end of ajax
		
		
        	}//end of function
        	
              
        	);
          
}


function getPredicatesIn(){
$(".object-search-in").click(
        	function() { 
        	var kk=$(this).attr('id');
        	$mainObj=$(this);
        	
        	$mainTd=$(this).closest('table').parent();
        	
        	
  $(this).closest('table').find("div").parent().remove();
    	
  $(this).closest('table').parent().nextAll().remove();
  var outht= "<td ><div><img src='images/right.jpg' width='16' height='10' alt='lefticon' /></div></td>";
  $(this).parent().append(outht);
	
	
	 $.ajax({
   type: "POST",
   url: "tripleSubject.json",
   data: "triplename="+ kk,
   dataType: "json",
   cache: false,
   async: false,
    
   success: function(data){
 
     if(data.triplecount==0){
    var innHt="<td rowspan='2' valign='top' class='normal' ><table border='0' cellspacing='0' cellpadding='8'><tr><td>End Of Search</td></tr></table></td>";
    $mainTd.parent().append(innHt);
     }
     if(data.triplecount>0){
     
     var innHt="<td rowspan='2' valign='top' class='normal' ><table border='0' cellspacing='0' cellpadding='8'>";
     $.each(data.pidic,
         function(i,item) { 
            if(i+1==data.triplecount)
        innHt=innHt+"<tr><td id='"+data.pidicIds[i]+"' class='predicate' >"+item+" </td></tr></table></td>";
        else
        innHt=innHt+"<tr><td id='"+data.pidicIds[i]+"'  class='predicate'>"+item+" </td></tr>";
        });
    
     $mainTd.parent().append(innHt);
     
    
      
     $('.predicate').bind('mouseover',function() {
     $(this).addClass("predicate-over");
      });
      
     $('.predicate').bind('mouseout',function() {
      $(this).removeClass("predicate-over");
      });
      
     $('.predicate').bind('click',getObjects());
     
    
      
     } //end of if
   } //end of success
 });//end of ajax

	 
	}); //end of class
	
} // end of getPredicates


function getPredicates(){
$(".object-search").click(
        	function() { 
        	var kk=$(this).attr('id');
        	
        	$mainObj=$(this);
        	
        	$mainTd=$(this).closest('table').parent();
      var sibs=$(this).siblings().length;
     
      if(sibs>1){
      $(this).next().next().remove();
      $mainTd.nextAll().remove();
      }
      if(sibs == 1){
       var outht= "<td valign='center'><div><img src='images/right.jpg' width='16' height='10' alt='lefticon' /></div></td>";
  		var nores="<td >End  Of Search</td>";
  		$(this).closest('tr').append(outht);
      $.ajax({
   type: "POST",
   url: "tripleSubject.json",
   data: "triplename="+ kk,
   dataType: "json",
   cache: false,
   async: false,
    
   success: function(data){
 
     if(data.triplecount==0){
     $mainTd.parent().append(nores);
     }
     if(data.triplecount>0){
     
     
     var innHt="<td rowspan='2' valign='top' class='normal' ><table border='0' cellspacing='0' cellpadding='8'>";
     $.each(data.pidic,
         function(i,item) { 
            if(i+1==data.triplecount)
        innHt=innHt+"<tr><td id='"+data.pidicIds[i]+"' class='predicate' >"+item+" </td></tr></table></td>";
        else
        innHt=innHt+"<tr><td id='"+data.pidicIds[i]+"'  class='predicate'>"+item+" </td></tr>";
        });
    
     $mainTd.parent().append(innHt);
     
   
      
     $('.predicate').bind('mouseover',function() {
     $(this).addClass("predicate-over");
      });
      
     $('.predicate').bind('mouseout',function() {
      $(this).removeClass("predicate-over");
      });
      
     $('.predicate').bind('click',getObjects());
     
    
      
     } //end of if
   } //end of success
 });//end of ajax
      }
     
	 
	}); //end of class
	
} // end of getPredicates
		   
</script>


<style type="text/css">
<!--
body {
	margin-top: 0px;
}
-->
</style></head>

<body>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
<%@ include file="/jsp/sempediaHeader.jsp" %>
  
</table>  
<hr width="80%" size="1" />
<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0">
  <tr>
    <td width="10%" bgcolor="#F4F4F4"><form method="post" name="sempediaSeedHome" action="sempediaHome.htm?action=searchSeedObjSemp">
    <span class="Header2-black"><strong>Seed Search</strong></span>
      <p class="normal-small">Enter some search terms to start your semantic browsing session:</p>

      <input type="text" class="ie6-input-text" name="objectNameSearch" id="objectNameIdForAjax" size="40"/>
        <input  type="submit" class="ie6-submit-button"  value="Search" />

        <label>        </label></form></td>
  </tr>
</table>
<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0" id="search_results">
  <tr>
    <td><span class="grey-small"><strong>Newbie Help:</strong> If you  click the icon <img src="images/object-page.gif" alt="" width="16" height="16" /> you will be taken to the object/class page which provides descriptions and semantic tags.</span></td>
  </tr>
  <tr>
    <td><span class="grey-small"><strong><c:out value="${message} " /> </strong></span></td>
  </tr>

  <tr>
    <td>
	<table border="0" cellspacing="0" cellpadding="0">
	<c:forEach var="classesList" items="${classesList}">
      <tr>

        <td valign="top" class="normal" >
			<table border="0" cellspacing="0" cellpadding="8">
			 <tr>
				 <td bgcolor="#F4F4F4" class="object-search" id=<c:out value="${classesList.objectId}" />><c:out value="${classesList.objectName} " /></td>
				 <td bgcolor="#F4F4F4" class="normal-small" id="subject"><a href="addObject.htm?action=getObjectDetailsFromSearch&objectName=<c:out value='${classesList.objectName}'/>&objectId=<c:out value='${classesList.objectId}' />"><img src="images/object-page.gif" width="16" height="16" /></a></td>
			 </tr>
			</table>
		</td>
	</tr>
    <tr><td>&nbsp;</td></tr>
    </c:forEach>
	<tr>
        <td class="normal"><img src="images/1px-transparent.gif" width="1" height="1" alt="d" /></td>
    </tr>
   
   </table>
  </td>
  </tr>
</table>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#4C88BE"><img src="images/1px-transparent.gif" width="1" height="1" alt="1px" /></td>
  </tr>
</table>

<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0">
  <tr>
    <td class="normal-small">Sempedia 2009 | Creative Commons License</td>
  </tr>
</table>
</body>
</html>

