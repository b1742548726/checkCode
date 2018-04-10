<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/include/taglib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>${application.customerName }【${application.code }】</title>
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
        
/*打印普通照片*/
div {   
    padding:0;
    margin:0;
}
.div_printNormal {
    height:90%; 
    width:auto;
    text-align:center;
    border:1px solid #FFFFFF;   /*360极速如果去掉这行打印会出现第一页空白*/
}


.div_printNormal p {
    height:5%;  
}

.div_printNormalContent {
    position:relative;
    height:95%;
}

.div_printNormal img {
    max-height:90%;
	max-width:90%;
    display:block;
    left:0;
    right:0;
    margin:0 auto;

}


/*打印身份证照片*/
/*
.div_printID {
    height:55%; 
    width:100%;
    text-align:center;
    border:1px solid #FFFFFF;
}
*/
.div_printID {
    height:80%; 
    width:100%;
    text-align:center;
    border:1px solid #FFFFFF;
}

.div_printIDContent {
    height:100%;
    position:relative;
    top:10%;
    transform:rotate(90deg) translateX(-10%);
}

.div_printID p {
    height:5%;  
}

.div_printID img {
    min-height:55%;
	max-height:85%;
	max-width:45%;
    left:0;
    right:0;
    margin:0 auto;
    position:relative;
	top:50%;
	transform:translateY(-50%);
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
<!--打印普通照片-->

<c:forEach items="${fileList }" var="photo">
    <div class="div_printNormal">
        <p>${application.customerName }【${application.code }】</p>
        <div class="div_printNormalContent">
            <img  src="${imagesStatic }${photo}">
        </div>
    </div>
</c:forEach>
<!--end 打印普通照片-->

<!--打印身份证照片-->
<c:forEach items="${idcardMapList }" var="idcardMap">
    <div class="div_printID" style="display:block;">
       <p>${application.customerName }【${application.code }】</p>
       <div class="div_printIDContent">
            <img  src="${imagesStatic }${idcardMap[0]}">&nbsp;
            <img  src="${imagesStatic }${idcardMap[1]}">
        </div>
    </div>
</c:forEach>
<!--end 打印身份证照片-->
</body>
<script>
function imgLoadFunc(img, callback) {
    if (img) {
        /*如果图片在缓存中，那就是complete，而不是onload*/
        if (img.complete) {
            if (typeof(callback) == "function") {
                callback(img);  
            }
            return true;    
        } else {
            img.addEventListener("load", function() {
                if (typeof(callback) == "function") {
                    callback(img);  
                }
            });
            return true;
        }
    } else {
        return false;   
    }   
}
 
window.onload = function() {
    var objs = document.images; 
    
    var callback = function(img) {
		if (img.parentElement.className === "div_printIDContent") {
			return;	
		}
        if (img.offsetHeight < img.offsetWidth) {
            img.parentElement.style.transform = "rotate(90deg)";    
            img.style.maxWidth = "95%";
            img.style.maxHeight = "55%";
            img.style.position = "relative";
            img.style.top = "50%";
            img.style.transform = "translateY(-50%)";
            //img.style.marginTop = "200px";
            //img.style.paddingBottom = "200px";
        }
    };
    
    for (var i=0;i<objs.length;i++) {
        imgLoadFunc(objs[i], callback);
    }
    window.print();
    window.close();
};

</script>
</html>