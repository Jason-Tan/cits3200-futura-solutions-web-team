<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.HashSet"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="model.TriplePOJO"%>
<%@ page import="dao.PredicateDao"%>
<%@ page import="dao.ObjectDao;"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sempedia | Making computers think about data the way we do</title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.autocomplete.js"></script>
<script>
	$(document).ready( function() {

		$(".top-button").hover( function() {
			$(this).addClass("top-button-active");
		}, function() {
			$(this).removeClass("top-button-active");
		});
		
		var queryPredicates = new Array();
		var queryObjects = new Array();
		<%
		ArrayList<TriplePOJO> triples = new ArrayList<TriplePOJO>();
		triples = (ArrayList<TriplePOJO>) request.getAttribute("triples");
  		Iterator<TriplePOJO> itrA = triples.iterator();
		int c=0;
		while (itrA.hasNext()) {
			TriplePOJO atriple = new TriplePOJO();
			atriple = itrA.next();
		%>	
			queryPredicates[<% out.print(c); %>]=-99;
			queryObjects[<% out.print(c); %>]=-99;
		<%
			c++;
			}
		%>

//////////////////////
		
		  $.ajax({
		        type: "GET",
		        url: "ObjectAutoComplete",
		        success: function(data) {
		            var dataArray = data.split("|");
		          // alert(dataArray);
		            $("#object-name").autocomplete(dataArray);
		        }
		    });
		    
//////////////////////
		    
		  $.ajax({
		        type: "GET",
		        url: "PredAutoComplete",
		        success: function(data2) {
		            var dataArray2 = data2.split("|");
		          // alert(dataArray);
		            $("#predicate-name").autocomplete(dataArray2);
		        }
		    });
		    
//////////////////////
				
		$(".predicate").hover(function() {
			$(this).addClass("select-button");
			}, function() {
			$(this).removeClass("select-button");
		});

//////////////////////		

		function removeItem(arrayName,arrayElement)
		 {
		    for(var i=0; i<arrayName.length;i++ )
		     { 
		        if(arrayName[i]==arrayElement)
		            arrayName.splice(i,1); 
		      } 
		  }

//////////////////////
		
		function getObjectCount(){
			var variables = queryPredicates.length;	//the number of variables is found by the length of the arrays - they should both be of the same length
			var queryString="count="+variables;
			for(var i=0; i<variables;i++){
				    queryString=queryString+"&preId"+i+"="+queryPredicates[i]+"&objId"+i+"="+queryObjects[i]; //add another array element to the queryString
				}
//alert(queryString);
			//send the queryString to the servlet that does the counting
			$.ajax( {
			type: "GET",
				url: "ObjectCount",
				dataType: 'json',
				data: queryString,
				success: function(data) {
					 $("#queryCount").html("<p><span class='Header1'><b>"+data+"</span><br><span class='normal-small'>Results</span></p>");	
				}
			});
			queryString="";
		}

//////////////////////

		function getObjectList(){
			var variables = queryPredicates.length;	//the number of variables is found by the length of the arrays - they should both be of the same length
			var queryString="count="+variables;
			for(var i=0; i<variables;i++){
				    queryString=queryString+"&preId"+i+"="+queryPredicates[i]+"&objId"+i+"="+queryObjects[i]; //add another array element to the queryString
				}
			//alert(queryString);	//display the queryString for testing
			//send the queryString to the servlet that does the counting
			$.ajax( {
				type: "GET",
				url: "ObjectQuery",
				dataType: 'json',
				data: queryString,
				success : function(resultObj) 
				{
					$("#displayObjects").empty(); 
				    $.each(resultObj, function(i,value) {    	 
					    $("#displayObjects").append("<table border='0' cellspacing='2' cellpadding='4'><tr><td><li><a href='ObjectPage?id="+resultObj[i].objId+"'><span class='normal'>"+resultObj[i].objName+"</span></a></li></td></tr></table>");  
// $("#displayObjects").append("<a class='result' href='ObjectPage?id="+resultObj[i].objId+"'><div id='"+resultObj[i].objId+"'>"+resultObj[i].objName+"</div></a>");	
				      	});
					}
				});
			queryString="";
		}
		$("#getObjButton").live('click',function(){
			getObjectList();	
		});

		$("#sem-browse").hide();
		$("#show-sem-browse").live('click',function(){
			$("#sem-browse").toggle('slow');			
		});		
		
//////////////////////

		$(".predicate").live('click',function(){
			var preId = this.id;
			var objId ="-1";
			var preArrayPos = $(this).attr('preArrayPos');
//alert(preArrayPos);
			var preName = $(".predName").filter("[preId='"+preId+"']").attr('preName');
//			alert(preId+" - "+objId+" - "+preArrayPos+" - "+preName);

			var isEmpty;
			
			if((queryPredicates[preArrayPos]==-99)&&(queryObjects[preArrayPos]==-99)){
				queryPredicates[preArrayPos]=preId;
				queryObjects[preArrayPos]=-1;
				isEmpty=true;
				$("#displayQuery").append("<p class='queryItem' predId='"+preId+"' arrayPos='"+preArrayPos+"'><span class='normal-small'><b>"+preName+"</b> equals anything <img class='deleteQueryItem' predId='"+preId+"' objId='-1' arrayPos='"+preArrayPos+"' src='images/close.gif' height='9' width='9'/></span></p>");
//alert("the position IS empty");
			}
			else{
				queryPredicates[preArrayPos]=preId;
				queryObjects[preArrayPos]=-1;
				isEmpty=false;
//alert("the position is NOT empty");
				$(".queryItem").filter("[predId='"+preId+"']").filter("[arrayPos='"+preArrayPos+"']").html("<p class='queryItem' predId='"+preId+"' arrayPos='"+preArrayPos+"'><span class='normal-small'><b>"+preName+"</b> equals anything <img class='deleteQueryItem' predId='"+preId+"' objId='-1' arrayPos='"+preArrayPos+"' src='images/close.gif' height='9' width='9'/></span></p>");
				
			}
			getObjectCount();
			$("#getObjButton").html("<input type='submit' value='Get More Objects'/>");		
//alert(queryPredicates);
//alert(queryObjects);
			
		});
		
//		$(".predicate").live('click',function(){
//			var preId = this.id;
//			var objId ="-1";
//			var preName = $(".predName").filter("[preId='"+preId+"']").attr('preName');
//			
//			var arrayPos = $.inArray(preId,queryPredicates);	//if the predicate doesn't exist in the array
//			if(arrayPos==-1){	//that is the predicate doesn't exist
//			queryPredicates.push(preId);
//			queryObjects.push(objId);
//			}
//			else{	//if the predicate already has an entry in the array
//				queryObjects[arrayPos]=objId; //we only need to edit the entry for the objectId because the predciateId can't change
//			}
//			if($(".queryItem").filter("[predId='"+preId+"']").length>0){ //means that the query item is already displayed
//				$(".queryItem").filter("[predId='"+preId+"']").html("<p class='queryItem' predId='"+preId+"'><span class='normal-small'><b>"+preName+"</b> equals anything <img class='deleteQueryItem' predId='"+preId+"' objId='-1' src='images/close.gif' height='9' width='9'/></span></p>");
//			} else {
//				$("#displayQuery").append("<p class='queryItem' predId='"+preId+"'><span class='normal-small'><b>"+preName+"</b> equals anything <img class='deleteQueryItem' predId='"+preId+"' objId='-1' src='images/close.gif' height='9' width='9'/></span></p>");
//				}
//			getObjectCount();
//			$("#getObjButton").html("<input type='submit' value='Get More Objects'/>");			
//		});

//////////////////////

		$(".object").live('click',function(){
			var preId = $(this).attr('preId');
			var objId = this.id;
			var objArrayPos = $(this).attr('objArrayPos');
//alert(objArrayPos);
			var preName = $(".predName").filter("[preId='"+preId+"']").attr('preName');
			var objName = $(".objectName").filter("[objId='"+objId+"']").attr('objName');
//			alert(preId+" - "+objId+" - "+objArrayPos+" - "+preName+" - "+objName);

			if((queryObjects[objArrayPos]==-99)&&(queryPredicates[objArrayPos]==-99)){
				queryObjects[objArrayPos]=objId;
				queryPredicates[objArrayPos]=preId;
				isEmpty=true;
				$("#displayQuery").append("<p class='queryItem' predId='"+preId+"' arrayPos='"+objArrayPos+"'><span class='normal-small' ><b>"+preName+"</b> equals <b>"+objName+"</b> <img class='deleteQueryItem' predId='"+preId+"' objId='"+objId+"' arrayPos='"+objArrayPos+"' src='images/close.gif' height='9' width='9'/></span></p>");
//alert("the position IS empty");
				}
			else{
				queryObjects[objArrayPos]=objId;
				isEmpty=false;
//alert("the position is NOT empty");
				$(".queryItem").filter("[predId='"+preId+"']").filter("[arrayPos='"+objArrayPos+"']").html("<p class='queryItem' predId='"+preId+"' arrayPos='"+objArrayPos+"'><span class='normal-small'><b>"+preName+"</b> equals <b>"+objName+"</b> <img class='deleteQueryItem' predId='"+preId+"' objId='"+objId+"' arrayPos='"+objArrayPos+"' src='images/close.gif' height='9' width='9'/></span></p>");
			}
			getObjectCount();
			$("#getObjButton").html("<input type='submit' value='Get More Objects'/>");
//alert(queryPredicates);
//alert(queryObjects);
		});

//		$(".object").live('click',function(){
//			var preId = $(this).attr('preId');
//			var objId = this.id;
//			var preName = $(".predName").filter("[preId='"+preId+"']").attr('preName');
//			var objName = $(".objectName").filter("[objId='"+objId+"']").attr('objName');
//			//before adding the predicate and object pair check that a corresponding entry doesn't already exist
//			var arrayPos = $.inArray(preId,queryPredicates);	//if the predicate doesn't exist in the array
//			if(arrayPos==-1){
//				queryPredicates.push(preId);
//				queryObjects.push(objId);
//			}
//			else{	//if the predicate already has an entry in the array
//				queryObjects[arrayPos]=objId; //we only need to edit the entry for the objectId because the predciateId can't change
//			}
//			
//			if($(".queryItem").filter("[predId='"+preId+"']").length>0){ //means that the query item is already displayed
//				$(".queryItem").filter("[predId='"+preId+"']").html("<p class='queryItem' predId='"+preId+"'><span class='normal-small'><b>"+preName+"</b> equals <b>"+objName+"</b> <img class='deleteQueryItem' predId='"+preId+"' objId='"+objId+"' src='images/close.gif' height='9' width='9'/></span></p>");
//			} else {
//				$("#displayQuery").append("<p class='queryItem' predId='"+preId+"'><span class='normal-small'><b>"+preName+"</b> equals <b>"+objName+"</b> <img class='deleteQueryItem' predId='"+preId+"' objId='"+objId+"' src='images/close.gif' height='9' width='9'/></span></p>");
//				}
//			getObjectCount();
//			$("#getObjButton").html("<input type='submit' value='Get More Objects'/>");
//		});

//////////////////////

		$(".deleteQueryItem").live('click',function() {
			 $("#displayObjects").empty(); 
				var arrayPos = $(this).attr('arrayPos');
			//remove the item from the two main arrays
			// remove the item from the support array
			//remove the item from the screen
			var preId = $(this).attr('predId');
			var objId = $(this).attr('objId');
			
			//var countVal = predQuery[preId];
			var countVal = $.inArray(preId, queryPredicates);
			if(countVal!=-1){
				//remove the array values
				$(".queryItem").filter("[predId='"+preId+"']").filter("[arrayPos='"+arrayPos+"']").remove();
				queryPredicates[arrayPos]=-99;
				queryObjects[arrayPos]=-99;
				}
			getObjectCount();
			//$("#getObjButton").html("<input type='submit' value='Get More Objects'/>");
			});	

	});
</script>
<style type="text/css">
<!--
body {
	margin-top: 0px;
}
-->
</style>
</head>
<body>
<form id="object">
<%

	PredicateDao pdao = new PredicateDao();
	ObjectDao odao = new ObjectDao();
	
	Iterator<TriplePOJO> itr2 = triples.iterator();
	while(itr2.hasNext()){
		TriplePOJO theTriple = new TriplePOJO();
		theTriple = itr2.next();
	%>
		<input type="hidden" class="objectName" objId="<% out.print(theTriple.getObjId()); %>" objName="<% out.print(odao.getObjectName(theTriple.getObjId())); %>" />
		<input type="hidden" class="predName" preId="<% out.print(theTriple.getPreId()); %>" preName="<% out.print(pdao.getPredName(theTriple.getPreId())); %>" />
	<%
		}
	%>
</form>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td rowspan="2" valign="bottom" class="Header1">
		<a href="index.jsp"><img src="images/sempedia.jpg" alt="" width="299" height="60" border="0" /></a></td>
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
				<td align="right" bgcolor="#dedede" class="normal-small">
				<a href="faq.html" class="normal-small-bold-link">faq</a> |
				<a href="about.html" class="normal-small-bold-link">about</a></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td align="right" nowrap="nowrap" class="Header1">
		<form method="post" name="seedSearch" action="SeedSearch"><label>
			<input type="text" class="normal" id="searchString" name="searchString" size="32" />
			<input name="submit2" type="submit" class="normal" id="submit2" value="Search" />
		</label>
		</form>
		</td>
	</tr>
</table>
<hr width="80%" size="1" />
<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0">
	<tr>
		<td valign="top"><strong><span>
		 <a href="ObjectPage?id=<% out.print(request.getAttribute("objId")); %>" class="Header2-black">
			<% out.print((String) request.getAttribute("objectName")); %>
		</a>
		</span></strong>
		<br>
		<span class="normal-small-green"><% out.print((String) request.getAttribute("objectUri")); %></span>	
		<%
			HashMap<Integer, String> classes = new HashMap<Integer, String>();
		 	classes = (HashMap<Integer, String>) request.getAttribute("classes");
		 	if (!(classes.size() == 0)) {
	 		out.print("<span class='normal-small'>is a </span>");
 			}
		 	Set<Integer> classids = new HashSet<Integer>();
		 	classids = classes.keySet();
		 	Iterator<Integer> itr1 = classids.iterator();
		 	while (itr1.hasNext()) {
	 		int classId = itr1.next();
 		%>
 		<strong>
 		  <span id="class-name">
 		    <a href="ClassPage?classId=<%  out.print(classId);  %>" class="small-link"><%  out.print(classes.get(classId));  %></a>
		</span>
		</strong>
		<%
 			}
 		%>
		</td>
		<td align="right" valign="top">
		<table border="0" cellspacing="0" cellpadding="4">
			<tr>
				<td class="normal-small"><a href="EditObject?id=<%out.print(request.getAttribute("objId"));%>"><img src="images/icons/green-pencil.png" alt="" width="16" height="16" /></a></td>
				<td class="normal-small">
					<a href="EditObject?id=<%out.print(request.getAttribute("objId"));%>" class="small-link">Edit This Page</a></td>
			</tr>
		</table>
		</td>
		<!--  this HTML is fine -->
	</tr>
</table>
<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0" id="object-panel">
	<tr>
	<td width="200" valign="top">
		<p class="normal-small">
		<img src="<% out.print(request.getAttribute("imageSrc")); %>" width="<%out.print(request.getAttribute("imageWidth"));%>" height="<%out.print(request.getAttribute("imageHeight"));%>" />
		<br />
		</p>
		  <table border="0" cellspacing="0" cellpadding="2">
			<tr>
			  <td>
				<span class="normal-small">
				  <% request.getAttribute("imgCaption"); %>
				</span>
			  </td>
			</tr>
		  </table>
		</td>
		<p></p>	
		<td colspan="2" valign="top">
		<p class="normal-small">
			<% out.print(request.getAttribute("text")); %>
		</p>
		</td>
	</tr>
</table>
<p></p>
<table width="80%" align="center" border="0" cellpadding="0" cellspacing="0">
	<tr>
	<td>
	<table border="0" cellpadding="4" cellspacing="0">
		<tr>
			<td><span class="normal"><strong>Click semantic tags </strong>below to construct a faceted query:</span></td>
		</tr>
	</table>
	</td>
	</tr>
	<tr>
	<td>
	<table width="80%" border="0" cellpadding="4" cellspacing="0">
		<tr id="show-sem-browse">
		  <td>
			<table width="80%" border="0" cellpadding="4" cellspacing="0">
			  <tr>
				<td width="16"><span class="object-search"><img src="images/icons/green-plus.png" alt="" width="16" height="16" /></span></td>
				<td><span class="object-search">Add Semantic Tag</span></td>
			  </tr>
			</table>
		  </td>
		</tr>
		<tr id="sem-browse">
			<td width="16">&nbsp;</td>
			<td>
				<table width="80%" border="0" align="left" cellpadding="4" cellspacing="0">
					<tr>
						<td width="1"></td>
						<td >
		  				  <form method="get" name="addTripleForm" action="AddTriple">		
		  				  <input type="hidden" value="<%out.print(request.getAttribute("objId"));%>" name="subId" id="subId"/>			
							<table border="0" cellspacing="0" cellpadding="4" id="add-tag">
							  <tr>
							    <td bgcolor="#EEEEEE" valign="top" nowrap="nowrap"><span class="normal-small">Property: <input type="text" name="predicate-name" id="predicate-name" class="normal" /></span></td>
							    <td bgcolor="#EEEEEE" valign="top" nowrap="nowrap"><span class="normal-small">Value: <input type="text" name="object-name" id="object-name" class="normal" /></span></td>
							  	<td bgcolor="#EEEEEE"><input type="submit" name="button" id="button" value="Save" /></td>
							  	<td bgcolor="#EEEEEE"><input type="button" name="cancel-add" id="cancel-add" value="Cancel" /></td>
							 </tr>
			    			</table>
						  </form>
		 			    </td>
	    			  </tr>
				</table>
			</td>
		</tr>
	</table>
	</td>
	</tr>
	<tr>
	<td>
	</td>
	</tr>
</table>

<!--  This is where the predicates and objects (triples) are listed -->
<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0">
	<tr>
		<td height="100%" colspan="2" valign="top" width="15%">
		<table border="0" cellspacing="0" cellpadding="2" id="semtag">
			<%
				Iterator<TriplePOJO> itr = triples.iterator();
				int count=0;
				while (itr.hasNext()) {
					TriplePOJO atriple = new TriplePOJO();
					atriple = itr.next();
			%>
			<tr>
				<td nowrap="nowrap">
					<div class="predicate" id="<% out.print(atriple.getPreId()); %>" preArrayPos="<% out.print(count); %>">
						<span class="normal">
						<% out.print(pdao.getPredName(atriple.getPreId())); %>
						</span>
					</div>
				</td>
				<td><img src="images/right.jpg" alt="-" width="16" height="10" /></td>
				<td><a href="ObjectPage?id=<% out.print(atriple.getObjId()); %>"><img src="images/icons/copper-file.png" alt="" width="16" height="16" /></a></td>
				<td nowrap>
					<div class="object" id="<% out.print(atriple.getObjId());%>" preId="<% out.print(atriple.getPreId()); %>"  objArrayPos="<% out.print(count); %>">
					<span class="normal">
					<% out.print(odao.getObjectName(atriple.getObjId())); %>
					</span></div>
				 </td>
			</tr>				
			<% count++;
			} %>
		</table>
		</td>
		<td valign="top">
		  <div id="resultCount">
			<table cellpadding="4" cellspacing="0" border="0" bgcolor="FFFFFF">
			  <tr>
				<td id="queryCount" valign="top"></td>
				<td></td>
				<td>
					<table cellpadding="4" cellspacing="0" border="0" bgcolor="FFFFFF">
					  <tr>
						<td id="displayQuery" valign="top">
						<table><tr><td>
						</td></tr></table>	
						</td>
						<td></td>
						<td id="displayObjects" valign="top" rowspan="2">
						</td>
					  </tr>
					</table>
				</td>
				<td></td>
				<td></td>
			  </tr>	
			  <tr>
				<td id="getObjButton" valign="top"></td>
				<td></td>
				<td ></td>
				<td></td>
			 	<td></td>
			  </tr>
			</table>
		</div>
		</td>
	</tr>
</table>
<!--  end triples and faceted search area -->
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr><td bgcolor="#4C88BE"><img src="images/1px-transparent.gif" width="1" height="1" alt="1px" /></td></tr>
</table>
<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0">
	<tr><td class="normal-small">Created and maintained by <a href="http://www.ivec.org">iVEC</a> - The Hub of Advanced Computing in WA | Creative Commons License</td></tr>
</table>
<p>&nbsp;</p>
</body>
</html>