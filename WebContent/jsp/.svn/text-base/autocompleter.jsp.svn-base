<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="../js/jquery.js" type="text/javascript">
</script>
<link rel="stylesheet" href="../css/styles.css" type="text/css">
<link rel="stylesheet" href="../css/jquery.autocomplete.css" type="text/css">
<script type="text/javascript" src="../js/jquery.bgiframe.min.js">
</script>
<script type="text/javascript" src="../js/jquery.autocomplete.js">
</script>
<script type="text/javascript">
$(document).ready(function(){

	
    $.ajax({
        type: "GET",
        url: "../ClassAutoComplete",
        success: function(data) {
            var dataArray = data.split("|");
           alert(dataArray);
            $("#example").autocomplete(dataArray);
        }
    });
});

</script>
<title></title>
</head>
<body>
API Reference:
<form><input id="example"> (try "C" or "E")</form>

<form method="get" action="../AutoComplete">
 <input type="submit" value="Submit"/>
</form>
</body>
</html>