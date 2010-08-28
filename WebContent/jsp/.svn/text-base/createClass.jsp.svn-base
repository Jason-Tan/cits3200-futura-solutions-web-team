<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a class</title>
<script type="text/javascript" src="../js/jquery-1.3.2.js"></script>
<script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
<link rel="stylesheet" href="../css/jquery.autocomplete.css" type="text/css" />
<script type="text/javascript">
var divIdName;
function addRow(div,value,x){
	if(document.getElementById(div)!=null)
		var ni = document.getElementById(div);
	if(document.getElementById(value)!=null)
		var numi = document.getElementById(value);
	if(document.getElementById(value)!=null){	
		var num = (document.getElementById(value).value -1)+ 2;
		numi.value = num;
		divIdName = "my"+num+"Div";
		var newdiv = document.createElement(div);
		newdiv.setAttribute("id",divIdName);
		newdiv.innerHTML = "<table border=\'0\' width=\'100%\' <tr valign=\'bottom\'><td valign=\'bottom\'><input type=\'text\' id=\'property\' name=\'property\' size=\'40\'></td><td valign=\'bottom\'><input type=\'button\' name=\'Remove\' value=\'Remove\' onclick=\"removeEvent(\'"+divIdName+"\',\'"+div+"\')\"></td></tr></table>";
		ni.appendChild(newdiv);
	}
}
function removeEvent(divNum,div){
	if(divNum != 'my1Div'){
		var d = document.getElementById(div);
		var olddiv = document.getElementById(divNum);
		d.removeChild(olddiv);
	}
}
function showCreatedClassDiv(){
	var classNameValue = document.getElementById('className').value;
	classNameValue = classNameValue.replace(/(\s+)+/g," ");
	classNameValue = classNameValue.replace(/^[\s]+/,'').replace(/[\s]+$/,'').replace(/[\s]{2,}/,' ');
	if(classNameValue != ''){
		document.getElementById('method').value = 'addClass';
		document.classForm.action="/Sempedia/createClass.htm?action=addClass";
		document.classForm.submit();
	}else{
		alert('Invalid Class Name Entered.');
		return false;
	}
}
function saveClass(){
	var finalList = '';
	var propertyNameValue;
	var propertiesArray = new Array();
	var countProperties = document.getElementById('theValue').value;
	var len = document.getElementsByName('property').length;
	var tempList = new Array();
	for(var j = 0 ;j<len;j++){
		propertiesArray[j] = document.getElementsByName('property')[j].value;
		propertyNameValue = propertiesArray[j];
		propertyNameValue = propertyNameValue.replace(/(\s+)+/g," ");
		propertyNameValue = propertyNameValue.replace(/^[\s]+/,'').replace(/[\s]+$/,'').replace(/[\s]{2,}/,' ');
		if(propertyNameValue != ''){
			finalList = finalList + propertyNameValue;
			finalList = finalList + '::';
		}else{
			alert('Invalid Property Name');
			return false;
		} 
	}
	tempList = finalList.split("::");
	if(document.getElementById('superClassPropertyList')!=null){
		var superClassPropetyLength = document.getElementById('superClassPropertyList').length;
		superClassPropetyLength = superClassPropetyLength - 1;
		var superProperty;
		var superPropertyTemp;
		var tempListTemp;
		for(var k = 0; k<(tempList.length)-1; k++){
			for(var i = 1; i<=superClassPropetyLength; i++){
				superProperty = document.getElementById('superClassPropertyList').options[i].value;
				superPropertyTemp = superProperty.toUpperCase();
				tempListTemp = tempList[k].toUpperCase();
				superPropertyTemp = superPropertyTemp.replace(/^[\s]+/,'').replace(/[\s]+$/,'').replace(/[\s]{2,}/,' ');
				tempListTemp = tempListTemp.replace(/^[\s]+/,'').replace(/[\s]+$/,'').replace(/[\s]{2,}/,' ');
				if(tempListTemp == superPropertyTemp){
					alert('Given Property '+superProperty+' Exists in one of its Super Class. Please select another property');
					return false;
				}else{}
			}
		}
	}else{
		document.getElementById('subClassId').value = document.getElementById('superClassId').value;
	}
	for(var count = 0; count<(tempList.length)-1; count++){
		for(var j = count+1; j<=(tempList.length); j++){
			if(tempList[count]==tempList[j]){
				alert('Invalid Class Property Entry as Property '+tempList[j]+' Already Exists');
				return false;
			}else{}
		}
	}
	if(document.getElementById('superClassPropertyList')!=null){
		document.getElementById('allProperties').value = finalList;
		document.getElementById('method').value = 'saveClass';
		document.classForm.action="/Sempedia/createClass.htm?action=saveClass";
		document.classForm.submit();
	}else{
		document.getElementById('allProperties').value = finalList;
		document.getElementById('method').value = 'addProperties';
		document.getElementById('className').value = document.getElementById('classNameHidden').value;
		document.classForm.action="/Sempedia/createClass.htm?action=addProperties";
		document.classForm.submit();
	}
}
function createSelectBox(box,selectBoxValue){
	var propertySelectBox = document.getElementById(box);
	var optionNew = document.createElement('option');
	optionNew.text = selectBoxValue;
	optionNew.value = selectBoxValue;
	propertySelectBox.options.add(optionNew);
}
function checkValueToDelete(){
	var deleteFlag;
	if(document.getElementById("propertySelect").value!=''){
		deleteFlag = confirm('Are You Sure to delete the '+document.getElementById("propertySelect").value+' property');
		if(deleteFlag){
			document.getElementById('method').value = 'deleteProperty';
			document.getElementById('propertyName').value = document.getElementById("propertySelect").value;
			document.getElementById('className').value = document.getElementById('classNameHidden').value;
			document.classForm.action="/Sempedia/createClass.htm?action=deleteProperty";
			document.classForm.submit();
		}else{}
	}else{
		alert('Invalid Property Selection');
		return false;
	}
}
function checkPropertyExists(){
	var finalList = '';
	var propertiesArray = new Array();
	var propertyNameValue;
	var countProperties = document.getElementById('theValue').value;
	var len = document.getElementsByName('property').length;
	var tempList = new Array();
	for(var j = 0 ;j<len;j++){
		propertiesArray[j] = document.getElementsByName('property')[j].value;
		propertyNameValue = propertiesArray[j];
		propertyNameValue = propertyNameValue.replace(/(\s+)+/g," ");
		propertyNameValue = propertyNameValue.replace(/^[\s]+/,'').replace(/[\s]+$/,'').replace(/[\s]{2,}/,' ');
		if(propertyNameValue != ''){
			finalList = finalList + propertyNameValue;
			finalList = finalList + '::';
		}else{
			alert('Invalid Property Name');
			return false;
		} 
	}
	tempList = finalList.split("::");
	for(var count = 0; count<(tempList.length)-1; count++){
		for(var j = count+1; j<=(tempList.length); j++){
			if(tempList[count]==tempList[j]){
				alert('Invalid Class Property Entry as Property '+tempList[j]+' Already Exists');
				return false;
			}else{}
		}
	}
	var subClassPropertyLength = document.getElementById('propertySelect').length;
	var superClassPropetyLength = document.getElementById('superClassPropertySelect').length;
	subClassPropertyLength = subClassPropertyLength - 1;
	superClassPropetyLength = superClassPropetyLength - 1;
	var startCount = subClassPropertyLength + 1;
	var superProperty;
	var superPropertyTemp;
	var tempListTemp;
	for(var k = 0; k<(tempList.length)-1; k++){
		for(var i = 1; i<=superClassPropetyLength; i++){
			superProperty = document.getElementById('superClassPropertySelect').options[i].value;
			superPropertyTemp = superProperty.toUpperCase();
			tempListTemp = tempList[k].toUpperCase();
			superPropertyTemp = superPropertyTemp.replace(/^[\s]+/,'').replace(/[\s]+$/,'').replace(/[\s]{2,}/,' ');
			tempListTemp = tempListTemp.replace(/^[\s]+/,'').replace(/[\s]+$/,'').replace(/[\s]{2,}/,' ');
			if(superPropertyTemp==tempListTemp){
				alert('Given Property '+tempList[k]+' Exists in one of its Super Class. Please select another property');
				return false;
			}else{}
		}
	}
	saveClass();
	
}

</script>
</head>
<body onload="addRow('myDiv','theValue','')">
<table width="100%">
<tr>
<td>
<table align="center" height="100%" border="0" width="100%">
	<tr height="110" align="left">
			<td align="left" valign="bottom"><img src="sempediaHome.htm?action=searchObjSemp" /></td>
			<%-- <td align="right" valign="bottom" width="10"><a href="javascript:tabDisplaying('createClass.htm');"  ><img src="images/addClass.JPG" height="22" width="70" /></a></td>--%>
			<td align="right" valign="bottom" width="10"><a href="createClass.htm?action=classPage"><img src="images/addClass.JPG" height="22" width="70" /></a></td>
			<td align="right" valign="bottom" width="10"><a href="createObject.htm"  ><img src="images/addObject.JPG" height="22" width="70" /></a></td>
			<td align="right" valign="bottom" width="260" >
				<input type="text" name="objectName" id="mainSearchForAjax" size="35" />
			</td>
			<td align="right" valign="bottom" width="60">
				<input type="button" name="mainSearch" value="Search"  />
			</td>
		</tr>
		<tr height="1" align="left">
			<td colspan="5" align="left" height="1"><img width="100%" src="images/logoBottomLine.JPG" /></td>
		</tr>
</table>
</td>
</tr>
<tr>
<td>
<table align="left" height="100%" border="0" width="100%">
	<tr align="center" >
		<td colspan="5" align="center">
			<table align="left" border="0">
				<tr>
					<font color="red" style="text-align: center" >
							<font color="red"><b><c:out value="${exceptionMessage}"/> </b></font>
							<b><c:out value="${classMessage}" /></b>
						</font>
					
					<td colspan="3">
						<form method="post" name="classForm">
							<table width="100%" border="0" align="left">
								<b style="font-size: 0.5cm">Class Details</b>
								<tr>
									<td width="80%" colspan="5" align="center">
										<font color="red">
											<b><c:out value="${message}" /></b>
										</font>
									</td>
								</tr>
								<tr>
									<td width="25%" align="left"> 
										<spring:message code="classname"></spring:message> <font color="red">*</font> :
									</td>
									<td colspan="4"> 
										<input type="text"  name="className" id="className" size="40" />
									</td>
								</tr>
								<tr>
									<td width="25%" colspan="5" align="center">
										<font color="red"><c:out value="${status.errorMessage}" /></font>
									</td>
								</tr>
								<tr>
									<td width="20%" align="left">
										<spring:message code="isa"></spring:message>  :
									</td>
									<td colspan="4">
										<input type="text" name="isA" id="isA"  size="40" />
									</td>
								</tr>
								<tr>
									<td  width="20%" colspan="5" align="center">
										<font color="red"><c:out value="${status.errorMessage}" /></font>
									</td>
								</tr>
								<tr>
									<td colspan="5" align="left">
										<input type="hidden" name="method" id="method" size="5" />
										<input type="hidden" name="allProperties" id="allProperties" size="5"/>
										<input type="hidden" id="subClassId" value='<c:out value="${classValue.subClassId}" />' size="5" name="subClassId"/>
										<input type="hidden" id="superClassId" value='<c:out value="${classValue.superClassId}" />' size="5" name="superClassId"/>
										<input type="hidden" id="propertyName" name="propertyName"/>
									 	<input align="left" type="button" value="<spring:message code="createClassButton"></spring:message>" onclick="showCreatedClassDiv()" />
									</td>
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
<table width="100%" border="0">
	<c:if test="${message == 'Class inserted successfully.' || viewMode == 'editMode'}">
		<tr>
			<td colspan="5">
				<img src="images/green_bottom_line.JPG"	height="5" width="50%" />
			</td>
		</tr>
		<c:if test="${viewMode == 'editMode'}">
		<tr>
			<td colspan="5">
				<b style="font-size: 0.5cm"><spring:message code="editClassDetails"></spring:message></b>
			</td>
		</tr>
		<tr>
			<td colspan="5">
				<font color="red"><b><c:out value="${editMessage}" /></b></font>
			</td>
		</tr>
		</c:if>
		<c:if test="${viewMode != 'editMode'}">
			<tr>
				<td colspan="5">
					<b style="font-size: 0.5cm"><spring:message code="classCreated"></spring:message></b>
				</td>
			</tr>
		</c:if>
		<tr>
			<td colspan="5">
				<spring:message code="class"></spring:message><b><c:out value="${classValue.subClassName}" />
				<input type="hidden" id="classNameHidden" name="classNameHidden" value='<c:out value="${classValue.subClassName}" />'/> </b>
			</td>
		</tr>
		<c:if test="${viewMode != 'editMode'}">
		<tr>
			<td colspan="5">
				<spring:message code="inherits"></spring:message><b><c:out value="${classValue.superClassName}" /></b>
			</td>
		</tr>
		</c:if>
		<c:if test="${viewMode == 'editMode'}">
			<tr>
				<td colspan="5">
					<b style="font-size: 0.5cm"><spring:message code="selectedClassProperties"></spring:message></b>
				</td>
			</tr>
			<tr>
				<td colspan="5">
					<c:forEach var="predicateValues" items="${classValue.subClassPredicates}">
						<font style="background-color:#DCDCDC"><c:out value="${predicateValues}" /></font>&nbsp;&nbsp;&nbsp;
					</c:forEach>
				</td>
			</tr>
		</c:if>
		<c:if test="${viewMode != 'editMode'}">
			<tr>
				<td colspan="5">
					<b style="font-size: 0.5cm"><spring:message code="inheritsProperties(Predicates)"></spring:message></b>
				</td>
			</tr>
		</c:if>
		<tr>
			<td colspan="5">
				<c:if test="${viewMode == 'editMode'}">
					<a href="javascript:addNewProperties()"><spring:message code="addNewProperties"></spring:message></a>&nbsp;&nbsp;&nbsp;<a href="javascript:deleteClassProperties()"><spring:message code="deleteProperties"></spring:message></a>
				</c:if>	
			</td>
		</tr>	
		<tr>
			<td colspan="5">
				<c:if test="${viewMode == 'editMode'}">	
					<select id="propertySelect" style="visibility: hidden;" name="propertySelect" onchange="">
							<option value="">---Select Property---</option>
					</select>
					<input type="button" style="visibility: hidden;" name="deleteProperty" id="deleteProperty" value="<spring:message code="deleteProperty"></spring:message>" onclick="checkValueToDelete()"/>
					
					<select style="visibility: hidden;" id="superClassPropertySelect" name="superClassPropertySelect" onchange="">
							<option value="">---Select Property---</option>
					</select>
					<c:forEach var="predicateValues" items="${classValue.subClassPredicates}">
						<script type="text/javascript">
							createSelectBox('propertySelect','<c:out value="${predicateValues}" />');
						</script>
					</c:forEach>
					<c:forEach var="superPredicateValues" items="${classValue.superClassPredicates}">
						<script type="text/javascript">
							createSelectBox('superClassPropertySelect','<c:out value="${superPredicateValues}" />');
						</script>
					</c:forEach>
				</c:if>
				<c:if test="${viewMode != 'editMode'}">
					<c:forEach var="predicateValues" items="${classValue.superClassPredicates}">
						<font style="background-color:#DCDCDC"><c:out value="${predicateValues}" /></font>&nbsp;&nbsp;&nbsp;
					</c:forEach>
					<select style="visibility: hidden;" id="superClassPropertyList" name="superClassPropertyList" onchange="">
							<option value="">---Select Property---</option>
					</select>
					<c:forEach var="superPredicateValues" items="${classValue.superClassPredicates}">
						<script type="text/javascript">
							createSelectBox('superClassPropertyList','<c:out value="${superPredicateValues}" />');
						</script>
					</c:forEach>
				</c:if>
			</td>
		</tr>
			<c:if test="${viewMode != 'editMode'}">	
				<tr>
					<td colspan="5">
						<spring:message code="property"></spring:message>
					</td>
				</tr>
				<tr>
					<td width="20%">
						<input type="hidden" value="0" id="theValue" name="theValue">
						<div id="myDiv"></div>
					</td>
					<td colspan="4" valign="bottom">
						<input type="button" value="<spring:message code='addNewProperty'></spring:message>" onclick="addRow('myDiv','theValue','')" />
					</td>
				</tr>
			</c:if>
			<c:if test="${viewMode == 'editMode'}">	
				<tr style="visibility: hidden;" id="propertyNameHidden1">
					<td colspan="5">
						<spring:message code="property"></spring:message>
					</td>
				</tr>
				<tr style="visibility: hidden;" id="propertyNameHidden2">
					<td width="20%" valign="bottom">
						<input type="hidden" value="0" id="theValue" name="theValue">
						<div id="myDiv" ></div>
					</td>
					<td colspan="4" valign="bottom">
						<input type="button" align="top"  value="<spring:message code='addNewProperty'></spring:message>" onclick="addRow('myDiv','theValue','')" />
					</td>
				</tr>
			</c:if>
			<c:if test="${viewMode == 'editMode'}">
				<tr style="visibility: hidden;" id="saveChangesHidden">
					<td colspan="5" align="left">
						<input type="button" value="<spring:message code='save'></spring:message>" onclick="checkPropertyExists()" />
					</td>
				</tr>
			</c:if>
			<c:if test="${viewMode != 'editMode'}">
				<tr>
					<td colspan="5" align="left">
						<input type="button" value="<spring:message code='saveClass'></spring:message>" onclick="saveClass()" />
					</td>
				</tr>
			</c:if>
	</c:if>
</table>
</td>
</tr>
<tr>
<td>
<table align="center"  height="100%" border="0" width="100%">
	<tr valign="bottom" align="left" >
		<td align="left" valign="bottom">
			<img width="100%" src="images/sempediaFooterAllRights.JPG" />
		</td>
	</tr>
</table>
</td>
</tr>
</table>
<%-- 
<display:table name="classesList" align="center" border="1" bgcolor="lavander" cellspacing="0" requestURI="/createClass.htm" >
    <display:column property="className" title="className"/>
    <display:column property="isA" title="isA"/>
</display:table>
--%>
<script type="text/javascript">
function findValue(li) {
//alert("findValue function...");
	if( li == null ) return alert("No match!");

	// if coming from an AJAX call, let's use the CityId as the value
	if( !!li.extra ) var sValue = li.extra[0];

	// otherwise, let's just display the value in the text box
	else var sValue = li.selectValue;
	//alert("The value you selected was: " + sValue);
}

function selectItem(li) {
//alert("selectItem function...");
	findValue(li);
}

function formatItem(row) {
//alert("formatItem .....");

	return row[0] + "&nbsp;&nbsp;<font color='red'><-- Edit </font>";
	//return row[0] + " (id: " + row[1] + ")";
	//return row[0];
}

function lookupAjax(){
//alert("lookupAjax....");
	var oSuggest = $("#objectIdForAjax")[0].autocompleter;

	oSuggest.findValue();

	return false;
}

function lookupLocal(){
//alert("lookupLoacl...");
	var oSuggest = $("#CityLocal")[0].autocompleter;

	oSuggest.findValue();

	return false;
}
//gurupavan
function openEdit(li){
	var con;
	con = confirm('Selected Class '+li.selectValue+' Already Exits Do You Want To Edit ');
	if(con){
		document.getElementById('className').value = li.selectValue;
		document.getElementById('method').value = 'editClass';
		document.classForm.action="/Sempedia/createClass.htm?action=editClass";
		document.classForm.submit();
	}else{
		alert('Please give another Class Name as Class Exits Already');
		document.getElementById('className').value='';
	}
}

//gurupavan
$(document).ready(function() {
//alert("ready....");
	$("#className").autocomplete(
		"jsp/getClasses.jsp",
		{
			delay:1,
			minChars:1,
			matchSubset:1,
			matchContains:1,
			cacheLength:10,
			onItemSelect:openEdit,
			onFindValue:findValue,
			formatItem:formatItem,
			autoFill:false,
			maxItemsToShow:10
		}
	);
	$("#isA").autocomplete("jsp/getClasses.jsp",
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
	$("#mainSearchForAjax").autocomplete(
		"jsp/getObjects.jsp",
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

});

function addNewProperties(){
	
	document.getElementById('propertySelect').style.visibility = 'hidden';
	document.getElementById('deleteProperty').style.visibility = 'hidden';
	//document.getElementById('deletePropertiesHidden').style.visibility = 'hidden';
	document.getElementById('propertyNameHidden1').style.visibility = 'visible'; 	
	document.getElementById('propertyNameHidden2').style.visibility = 'visible'; 
	document.getElementById('saveChangesHidden').style.visibility = 'visible';	
}
function deleteClassProperties(){
	document.getElementById('propertyNameHidden1').style.visibility = 'hidden'; 	
	document.getElementById('propertyNameHidden2').style.visibility = 'hidden';
	document.getElementById('saveChangesHidden').style.visibility = 'hidden';	
	document.getElementById('propertySelect').style.visibility = 'visible';
	document.getElementById('deleteProperty').style.visibility = 'visible';
	//document.getElementById('deletePropertiesHidden').style.visibility = 'visible'; 	 	
}
</script>

</body>
</html>
