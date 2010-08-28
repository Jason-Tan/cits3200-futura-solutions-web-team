<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.HashSet"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="dao.PredicateDao"%>
<%@ page import="dao.ObjectDao"%>
<%@ page import="model.TriplePOJO;"%>
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
		
		  $.ajax({
		        type: "GET",
		        url: "ClassAutoComplete",
		        success: function(data) {
		            var dataArray = data.split("|");
		          // alert(dataArray);
		            $("#class-to-add").autocomplete(dataArray);
		        }
		    });

		  $.ajax({
		        type: "GET",
		        url: "ObjectAutoComplete",
		        success: function(data) {
		            var dataArray = data.split("|");
		          // alert(dataArray);
		            $("#object-name").autocomplete(dataArray);
		        }
		    });

		  $.ajax({
		        type: "GET",
		        url: "PredAutoComplete",
		        success: function(data2) {
		            var dataArray2 = data2.split("|");
		          // alert(dataArray);
		            $("#predicate-name").autocomplete(dataArray2);
		        }
		    });
		// ---------- hide and seek --------------- //
			$(".top-button").hover( function() {
				$(this).addClass("top-button-active");
			}, function() {
				$(this).removeClass("top-button-active");
			});
			$("#add-sem-tag").hide("");
			$("#add-tag-btn").click(function(event){
			     $("#add-sem-tag").toggle("");
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
<table width="80%" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td rowspan="2" valign="bottom" class="Header1"><a
			href="index.jsp"> <img src="images/sempedia.jpg" alt=""
			width="299" height="60" border="0" /></a></td>
		<td width="90%" rowspan="2" valign="bottom" class="normal-small">
		<table border="0" cellspacing="8" cellpadding="6">
			<tr>
				<td width="52" class="normal-medium">&nbsp;</td>
				<td class="top-button"><a href="jsp/addClass.jsp"
					class="normal-medium">Add Class</a></td>
				<td class="top-button"><a href="jsp/addObject.jsp"
					class="normal-medium">Add Object </a></td>
			</tr>
		</table>
		</td>
		<td align="right" class="Header1">
		<table border="0" cellspacing="0" cellpadding="8">
			<tr>
				<td align="right" bgcolor="#dedede" class="normal-small"><a href="faq.html" class="normal-small-bold-link">faq</a> | <a href="about.html" class="normal-small-bold-link">about</a></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td align="right" nowrap="nowrap" class="Header1">
		<form method="post" name="seedSearch" action="SeedSearch"><label>
		<input type="text" class="normal" id="searchString" name="searchString" size="32" /> <input
			name="submit2" type="submit" class="normal" id="submit2"
			value="Search" /> </label>
		</form></td>
	</tr>
</table>
<hr width="80%" size="1" />
<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0">
	<tr>
		<td colspan="3" valign="top" nowrap="nowrap" class="normal-small">
			Return to <a href="ObjectPage?id=<% out.print(request.getAttribute("objId")); %>" class="normal-small-bold-link"> 
			<% out.print(request.getAttribute("objectName")); %>
			</a>
		</td>
	</tr>
	<tr>
		<td width="20%" valign="top" nowrap="nowrap">
		<div id="edit-title-div">
		
		<form id="editObjectName" name="editObjectName" method="get" action="EditObjectName"><label>		
			<input type="hidden" id="id" name="id" value="<% out.print(request.getAttribute("objId")); %>"/>
			<input class="Header2-black" name="newObjectName" type="text" id="newObjectName" size="42" value="<%out.print(request.getAttribute("objectName"));%>" /> <br />
			</label> <label> <input type="submit" value="Save Title" /></label>
		</form>
		</div>
		</td>
		<td width="40%" valign="top" nowrap="nowrap" align="right">
		<p><span class="normal-small">is a </span><strong><span><a href="class.html" class="small-link"></a></span></strong></p>
		</td>
		<td valign="top" nowrap="nowrap">
		<div id="edit-class-div">
		<%  HashMap<Integer,String> classes = new HashMap<Integer,String>();
			classes = (HashMap<Integer,String>)request.getAttribute("classes");
			Set<Integer> classIds = new HashSet<Integer>();
				classIds = classes.keySet();
				Iterator<Integer> itr = classIds.iterator();
				while(itr.hasNext()){
					int nextId = (Integer)itr.next();
			%>
					<span class="normal-small"><%  out.print(classes.get(nextId)); %></span>
				<a href="DeleteObjCla?claId=<%  out.print(nextId); %>&objId=<%  out.print(request.getAttribute("objId")); %>">
					<image src="images/wyzzicons/close.gif" width="9" height="9" />
				</a><br />
				<%  
					}
				%>
		  </div>
		   <form id="editClassList" name="editClassList" method="get" action="EditClassList">
			      <input type="hidden" name="objId" id="objId" value="<%  out.print(request.getAttribute("objId")); %>"/>
			    <label>
			      <input type="text" name="class-to-add" id="class-to-add" size="22"/>
		        </label>
			    <label>
			      <input type="submit" name="save-class-btn" id="save-class-btn" value="Save Class(es)" />
		        </label>
		    </form>
		</td>
	</tr>
</table>
<table width="80%" border="0" align="center" cellpadding="8"
	cellspacing="0" id="object-panel">
	<tr>
		<td colspan="2" valign="top">
		<form id="EditTextForm" name="EditTextForm" method="post" action="EditObjectText">
			<input type="hidden" id="objId" name="objId" value="<% out.print(request.getParameter("id")); %>" />
		  <div id="content-textarea" class="right-align-form">
		    <label>
			  <textarea name="description" style="width:100%" rows="12" class="description-content-textarea" id="description"><% out.print(request.getAttribute("text")); %></textarea> 
			</label> 
			<label>
			  <input name="submit" type="submit" class="submit-button" id="submit" value="Change Description" />
			</label>
		  </div>
		</form>
		<p class="normal"><strong>Add an image</strong></p>
		<form name="UploadImage" enctype="multipart/form-data" method="post" action="UploadImage">
			<table border="0" cellspacing="0" cellpadding="4">
			<tr>
				<td><span class="normal">Upload an Image</span></td>
				<td>
				  <label>
					<input type="file" name="image" id="image" />
				  </label>
				</td>
			</tr>
			<tr>
				<td>
					<label>
						<span class="normal">Image caption</span>
					</label>
				</td>
				<td>
					<input name="caption" type="text" id="caption" size="52" />
					<input type="hidden" name="imgUploadObjId" id="imgUploadObjId" value="<% out.print(request.getParameter("id")); %>" />
	
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><label> <span class="normal"><input type="submit" value="Upload Image"/></span></label></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
				<p class="normal-small">
				
				<% String caption = (String) request.getAttribute("imgCaption");
					if(caption!=null){
					out.print(caption);
					}%>
				</p>
				<p>
				<%
					String picSrc = (String)request.getAttribute("imgSrc");
					if(picSrc!=null){
						out.print("<img src=\"pics/"+picSrc+" />");
					}
				 %>	
					</p>
				</td>
			</tr>
		</table>
		</form>
		<p class="normal-small">&nbsp;</p>
		</td>
	</tr>
</table>
<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0">
	<tr>
		<td><span class="Header2-black">Semantic Browse</span></td>
	</tr>
</table>
<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0">
	<tr>
		<td height="100%" valign="top">
		<table border="0" cellspacing="0" cellpadding="6" id="add-tag">
			<tr>
				<td colspan="2" valign="top" nowrap="nowrap">
					<span class="normal">
						<input type="submit" id="add-tag-btn" value="+ Add a Semantic Tag" />
					</span>
				</td>
			</tr>
		</table>
		<form method="get" action="AddTriple">
		  <table id="add-sem-tag">
			<tr>	
			  <td valign="top" nowrap="nowrap">
					<span class="normal-small">Property</span>
					<br />
					<input type="hidden" id="subId" name="subId" value="<% out.print(request.getAttribute("objId")); %>"/>
					<input name="predicate-name" type="text" class="normal" id="predicate-name" size="32" />
			  </td>
			  <td valign="top" nowrap="nowrap">
			  	<span class="normal-small">Value<br /></span> 
					<span class="normal-small">
						<input name="object-name" type="text" class="normal" id="object-name" size="32" />
						<input type="submit" name="cancel-add" id="cancel-add" value="Save Tag" />
					</span>
			  </td>
			</tr>
		  </table>
		</form>
		<form method="post" action="EditTriple" >
		<table border="0" cellspacing="0" cellpadding="6">
    <%  ArrayList<TriplePOJO> triples = new ArrayList<TriplePOJO>();
    	triples = (ArrayList<TriplePOJO>)request.getAttribute("triples");
    	PredicateDao pdao = new PredicateDao();
    	ObjectDao odao = new ObjectDao();
    	Iterator<TriplePOJO> itr2 = triples.iterator();	
    	while(itr2.hasNext()){		
    		TriplePOJO atriple = new TriplePOJO();
    		atriple = itr2.next();

	        out.print("<tr><td><div id='tag3-predicate'><span class='normal'>"+ pdao.getPredName(atriple.getPreId()) +"</span></div></td>");
	        out.print("<td><img src='images/right.jpg' alt='-' width='16' height='10' /></td>");
	        out.print("<td><div id='tag3-value'><span class='normal'>"+ odao.getObjectName(atriple.getObjId()) +"</span></div></td>");
	        out.print("<td><div><a href='DeleteTriple?tripleId="+atriple.getTripleId()+"'><span class='normal'><image src='images/wyzzicons/close.gif' width='9' height='9' /></a></span></div></td>");
	        out.print("<td class='tag-modify' id='semtag3-edit' >&nbsp;</td></tr>");
       } %>
     </table>
		</form>
		</td>
	</tr>
</table>
<table width="80%" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td bgcolor="#4C88BE"><img src="images/1px-transparent.gif"
			width="1" height="1" alt="1px" /></td>
	</tr>
</table>
<table width="80%" border="0" align="center" cellpadding="8"
	cellspacing="0">
	<tr>
		<td class="normal-small">Created and maintained by <a href="http://www.ivec.org">iVEC</a> - The Hub of Advanced Computing in WA | Creative Commons License</td>
	</tr>
</table>
<p>&nbsp;</p>
</body>
</html>