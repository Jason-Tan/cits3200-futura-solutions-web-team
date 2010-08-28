<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="model.ObjectPOJO"%>
<%@ page import="model.SearchItemPojo;"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sempedia | Making computers think about data the way we do</title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.autocomplete.js"></script>
<script><!--
$(document).ready( function() {

	$("#classes-panel").hide();
	$("#classes-panel-label").live('click',function(){
		$("#classes-panel").show();
		$("#objects-panel").hide();
	//	alert("classes label");
	});
	$("#objects-panel-label").live('click',function(){
		$("#objects-panel").show();
		$("#classes-panel").hide();
//alert("objects label");		
	});

	$(".top-button").hover( function() {
		$(this).addClass("top-button-active");
	}, function() {
		$(this).removeClass("top-button-active");
	});
	
		$.ajax({
	    	type: "GET",
	    	url: "ObjectAutoComplete",
	    	success: function(data) {
	       	 	var dataArray = data.split("|");
	      	//	 alert(dataArray);
	     	   $("#searchString").autocomplete(dataArray);
			}
		});
		
		var highLevel=1;

		$(".objItem").live('click',function() {
			var level = $(this).attr('level');
			var list = $(".objItem").map(function(){return $(this).attr("level");}).get();
			var objId = $(this).attr('objId');
			var holderId = $(this).attr('holderId');
			
			if(highLevel>level){

				$(".preItem[level='"+level+"']").not("[objId='"+objId+"']").show("slow");
				for(var i=level;i<=highLevel;i++){
					$(".objHolder[level='"+i+"']").remove();
					$(".preHolder[level='"+i+"']").remove();
					$(".arrow[level='"+i+"']").remove();
				}
				highLevel=level;
			}
			else{
				$(".preItem[level='"+level+"']").not("[objId='"+objId+"']").hide("slow");
			highLevel=level+1;
			

			$(".objHolder").filter("[level='"+(parseFloat(level)-1)+"']").filter("[holderId='"+holderId+"']").after("<td class='arrow' level='"+(parseFloat(level))+"'><img src='images/right.jpg' alt='' width='16' height='10' /></td><td class='preHolder' level='"+level+"' holderId='"+holderId+"'></td>");
			$.ajax( {
				type : "GET",
				url : "PredList",
				dataType: "json",
				data : "id="+objId,
				success : function(resultObj) {
				$.each(resultObj, function(index, value){
					$(".preHolder").filter("[level='"+level+"']").filter("[holderId='"+holderId+"']").append("<table border='0' cellspacing='2' cellpadding='4'><tr><td class='preItem' level='"+(parseFloat(level)+1)+"' subId='"+objId+"' preId='"+value.preId+"' holderId='"+holderId+"' nowrap='nowrap' bgcolor='#EEEEEE'><span class='normal-small'>"+value.preName+"</span></td></tr></table>");
					});
					}
				});
			}
		});

		$(".preItem").live('click',function() {
			
			var level = $(this).attr('level');
			var list = $(".preItem").map(function(){return $(this).attr("level");}).get();
			var preId = $(this).attr('preId');
			var holderId = $(this).attr('holderId');
			var subId = $(this).attr('subId');
			var objId = $(this).attr('objId');		

			if(highLevel>level){

				$(".preItem[level='"+level+"']").not("[preId='"+preId+"']").show("slow");

				for(var i=level;i<=highLevel;i++){
					$(".preHolder[level='"+i+"']").remove();
					$(".objHolder[level='"+i+"']").remove();
					$(".arrow[level='"+i+"']").remove();
				}
				highLevel=level;
			}
			else{

				$(".preItem[level='"+level+"']").not("[preId='"+preId+"']").hide("slow");
				highLevel=level+1;
				
				$(".preHolder").filter("[level='"+(parseFloat(level)-1)+"']").filter("[holderId='"+holderId+"']").after("<td class='arrow' level='"+(parseFloat(level))+"'><img src='images/right.jpg' alt='' width='16' height='10' /></td><td class='objHolder' level='"+level+"' holderId='"+holderId+"'></td>");
				$.ajax( {
					type : "GET",
					url : "ObjList",
					dataType: "json",
					data : "subId="+subId+"&preId="+preId,
					success : function(resultObj) {
						$.each(resultObj, function(index, value){
						$(".objHolder").filter("[level='"+level+"']").filter("[holderId='"+holderId+"']").append("<table border='0' cellspacing='0' cellpadding='4'><tr><td bgcolor='#EEEEEE'><a href='ObjectPage?id="+value.objId+"'><img src='images/icons/copper-file.png' width='16' height='16' /></a></td><td class='objItem' level='"+(parseFloat(level)+1)+"' objId='"+value.objId+"' holderId='"+holderId+"' nowrap='nowrap' bgcolor='#EEEEEE'><span class='normal-small'>"+value.objName+"</span></td></tr></table>");
				});
			}
		});
	}
	});					
});
--></script>
<style type="text/css">
<!--
body {
	margin-top: 0px;
}
-->
</style>
</head>
<body>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td rowspan="2" valign="bottom" class="Header1"><a href="index.jsp">
			<img src="images/sempedia.jpg" alt="" width="299" height="60" border="0" /></a></td>
			<td width="90%" rowspan="2" valign="bottom" class="normal-small">
			<table border="0" cellspacing="8" cellpadding="6">
		  	  <tr>
				<td width="52" class="normal-medium">&nbsp;</td>
				<td class="top-button"><a href="jsp/addClass.jsp" class="normal-medium">Add Class</a></td>
				<td class="top-button"><a href="jsp/addObject.jsp" class="normal-medium">Add Object </a></td>
			  </tr>
			</table>
		</td>
		<td align="right" class="Header1">
    	<table border="0" cellspacing="0" cellpadding="8">
      		<tr>
        		<td align="right" bgcolor="#dedede" class="normal-small"><a href="" class="normal-small-bold-link">faq</a> | <a href="" class="normal-small-bold-link">about</a></td>
      		</tr>
    	</table>
	</td>
	</tr>
	<tr>
		<td align="right" nowrap="nowrap" class="Header1">
		  <form method="get" name="seedSearch" action="SeedSearch">
		   <label>
			 <input type="text" class="ie6-input-text" name="searchString2" id="searchString2" size="32" />
			 <input type="submit" class="ie6-submit-button" value="Search" />
		   </label>
		  </form>
		</td>
	</tr>
	</table>
<hr width="80%" size="1" />
<table border="0" align="center" cellpadding="8"
	cellspacing="0" width="80%">
	<tr>
		<td width="10%" bgcolor="#F4F4F4">
		<form method="post" name="seedSearch" action="SeedSearch"><span
			class="Header2-black"><strong>Seed Search</strong></span>
		<p class="normal-small">Enter some search terms to start your semantic browsing session:</p>
		<input type="text" class="ie6-input-text" id="searchString"
			name="searchString" size="40" /> <input type="submit"
			class="ie6-submit-button" value="Search" /> <label> </label></form>
		</td>
	</tr> 
</table>
<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0" id="search_results">
  <tr>
	<td>
	  <span class="grey-small"><strong>Newbie Help:</strong> If you click the icon <img src="images/icons/copper-file.png" alt="" width="16" height="16" /> you will be taken to the object/class page which provides descriptions and semantic tags.</span>
	</td>
  </tr>
  </table>
  	<table id="objects-panel" width="80%" align="center">
  		<tr><td>
  			<table border="0"  cellspacing="0" cellpadding="8">
			<tr><td>
				<table>
					<tr><td>
						<b><span class="normal" id="objects-panel-label">Objects</span></b>						
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
						<b><span class="normal-small" id="classes-panel-label">Classes</span></b>
					</td></tr>
				</table>
			</td></tr>
			</table>
				<table border="0" cellspacing="0" cellpadding="6">
				<tr><td>
					<%	HashMap<Integer,SearchItemPojo> objects = new HashMap<Integer,SearchItemPojo>();
						objects = (HashMap<Integer,SearchItemPojo>) request.getAttribute("objects");
						Set<Integer> objKeyset = objects.keySet();
			
						Iterator<Integer> itrObj = objKeyset.iterator();
						while (itrObj.hasNext()) {
							int objId = itrObj.next();
							SearchItemPojo sip = objects.get(objId);
							
							String objName = sip.getName();
							String objUri = sip.getUri();
							%>
							<table cellpadding="2"><tr><td>	
								<a href="ObjectPage?id=<% out.print(objId); %>"><span class="normal"><% out.print(objName); %></span></a>
							</td><td>
							<tr><td>
								<span class="normal-small-green"><% out.print(objUri); %></span>				
							</td><td>
							<tr><td>
								<img src="images/-transparent.gif" height="1" width="1" />
							</td></tr>
							</table>					
					<% } %>
			
						</td></tr>
					</table>
		</td></tr>
	</table>
	
	<table id="classes-panel" width="80%" align="center">
		<tr><td>
			<table border="0" cellspacing="0" cellpadding="8">
			<tr><td>
			<table><tr>
				<td>
					<b><span class="normal-small" id="objects-panel-label">Objects</span></b>
				</td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>
				<b><span class="normal" id="classes-panel-label">Classes</span></b>
				</td></tr>
			</table>
			</td></tr>
			</table>
			<table border="0" cellspacing="0" cellpadding="6">
			<tr><td>
				<%	HashMap<Integer,SearchItemPojo> classes = new HashMap<Integer,SearchItemPojo>();
					classes = (HashMap<Integer,SearchItemPojo>) request.getAttribute("classes");
				
					Set<Integer> claKeyset = classes.keySet();
					Iterator<Integer> itrCla = claKeyset.iterator();
					while (itrCla.hasNext()) {
						int claId = itrCla.next();
						SearchItemPojo sip = classes.get(claId);
						String claName = sip.getName();
						String claUri = sip.getUri();				
						%>		
						<table cellpadding="2">
							<tr><td>		
								<a href="ClassPage?classId=<% out.print(claId); %>"><span class="normal"><% out.print(claName); %></span></a>
							</td><td>
							<tr><td>
								<span class="normal-small"><% out.print(claUri); %></span>					
							</tr></td>
							<tr><td>
								<img src="images/1px-transparent.gif" height="1" width="1" />
							</td></tr>
						</table>
		 		<% } %>
		
					</td></tr>
				</table>
			</td></tr>
		</table>
	
	<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td bgcolor="#4C88BE"><img src="images/1px-transparent.gif" width="1" height="1" alt="1px" /></td>
		</tr>
	</table>
	<table width="80%" border="0" align="center" cellpadding="8"
		cellspacing="0">
		<tr>
			<td class="normal-small">Created and maintained by <a href="http://www.ivec.org">iVEC</a> - The Hub of Advanced Computing in WA | Creative Commons License</td>
		</tr>
	</table>
</body>
</html>