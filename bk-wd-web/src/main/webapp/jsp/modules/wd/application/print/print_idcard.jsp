<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>身份证打印</title>
</head>
<body>
<style>
html,body {
    font-size:14px;
    box-sizing:content-box;
    height:100%;
    width:98%;
    margin:0 auto;
    padding:0;
}
        
/*打印身份证照片*/
.div_printID {
    height:80%; 
    width:100%;
    text-align:center;
    border:1px solid #FFFFFF;
}

.div_printIDContent {
    /*height:100%;*/
    position:relative;
    top:10%;
    margin:0 auto;
    left:0;
    right:0;
}

.div_printIDContent > div {
    height:5.4cm;
    width:8.56cm;
    margin:0 auto;
    margin-top:3rem;
    border-radius:10px;
    overflow:hidden;
}

.div_printIDContent > div img {
    height:100%;
    width:100%;
}

.div_printID p {
    height:5%;  
}

.div_printID img {
    min-height:55%;
    left:0;
    right:0;
    margin:0 auto;
    position:relative;
    top:50%;
    transform:translateY(-50%);
    -webkit-filter: brightness(150%);
    filter: brightness(150%);
}

.div_printID img:nth-of-type(odd) {
    margin-right:50px;
}
/*end 打印身份证照片*/

@media print {
    
   div.div_printNormal, div.div_printID {
       page-break-before:always;
   }
       
   @page {
     margin:0;
   }
}
</style>

<!--打印身份证照片-->
    <div class="div_printID" style="display:block;">
       <p></p>
       <div class="div_printIDContent">
            <div><img  src="${imagesStatic }${idcard1}"></div>
            <div><img  src="${imagesStatic }${idcard2}"></div>
        </div>
    </div>
  
<!--end 打印身份证照片-->
</body>
<script>
window.onload = function() {
    window.print();
    window.close();
};
</script>
</html>