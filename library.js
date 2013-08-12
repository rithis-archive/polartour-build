(function(){var e,a,h,f,b,l,n,m,j,d,c,p,g,i,o,k=function(q,r){return function(){return q.apply(r,arguments)}};l=require("cruder");f=require("async");l=require("cruder");l=require("cruder");l=require("cruder");l=require("cruder");d=require("jade");p=require("path");j=require("fs");l=require("cruder");l=require("cruder");m=require("fileupload");l=require("cruder");p=require("path");l=require("cruder");g=require("superagent");l=require("cruder");c=require("jsdom");b=require("memory-cache");l=require("cruder");f=require("async");l=require("cruder");l=require("cruder");l=require("cruder");l=require("cruder");n=require("dateformat");c=require("jsdom");i=require("tds");e=(function(){function q(r){this.url=r;this.result=null}q.prototype.refresh=function(s){var r=this;return c.env({url:this.url,scripts:["http://code.jquery.com/jquery.js"],done:function(v,u){var w,t;if(v){s(v);return}if(u.document.innerHTML.indexOf("page not found")>=0){s("page not found");return}t={currencies:[],rates:{}};w=u.$;w("thead td").each(function(){return t.currencies.push(w(this).text().trim())});w("tbody tr").each(function(){var x;x=w("th",this).text().trim();t.rates[x]={};return w("td",this).each(function(z){var y;y=t.currencies[z];return t.rates[x][y]=w(this).text().trim()})});r.result=t;return s(null,t)}})};return q})();a=(function(){function q(t,r,u,s){this.host=t;this.port=r;this.username=u;this.password=s;this.result=null;this.connection=null}q.prototype.refresh=function(t){var r,s=this;if(this.connection){return this._refresh(t)}else{r=new i.Connection({host:this.host,port:this.port,userName:this.username,password:this.password});return r.connect(function(u){if(u){return t(u)}else{s.connection=r;s.connection.on("error",function(){s.connection.end();return s.connection=null});return s._refresh(t)}})}};q.prototype._refresh=function(v){var s,r,t,u=this;s=n("dd.mm.yyyy");r={currencies:[],rates:{}};r.rates[s]={};t=this.connection.createStatement("EXEC up_WEB_3_job_currency");t.on("row",function(x){var z,w,y;w=x.getValue("rate");z=x.getValue("alias_from");y=x.getValue("alias_to");if(y==="RUB"){if(r.currencies.indexOf(z)===-1){r.currencies.push(z);return r.rates[s][z]=w}}});t.on("done",function(){u.result=r;return v(null,r)});return t.execute()};return q})();l=require("cruder");l=require("cruder");g=require("superagent");l=require("cruder");o=require("lodash");h=(function(){function q(r){this.key=r;this.getList=k(this.getList,this);this.subscribe=k(this.subscribe,this);this.call=k(this.call,this)}q.prototype.call=function(t,r,s){return g.get("http://api.unisender.com/ru/api/"+t+"?format=json&api_key="+this.key).query(r).end(s)};q.prototype.subscribe=function(r){var s=this;return this.getList(function(t){var u;u={list_ids:t,fields:{email:r}};return s.call("subscribe",u)})};q.prototype.getList=function(s){var r=this;return this.call("getLists",{},function(u){var v,t;t="polartour.ru";v=false;u.body.result.forEach(function(w){if(w.title===t){return v=w}});if(v){s(v.id)}return r.call("createList",{title:t},function(w){return s(w.body.result.id)})})};return q})();l=require("cruder");module.exports=function(ap,R){var M,aB,aM,ac,aj,ae,ak,aP,ax,y,aa,Q,I,E,A,af,s,P,D,u,aA,aI,B,aN,q,J,V,G,aL,H,L,W,ah,aJ,O,au,aG,ar,aE,aH,am,C,z,w,Y,al,aF,x,ai,ao,F,Z,aK,U,S,an,ab,az,aO,X,v,ag,aC,T,aw,aq,at,ad,ay,av,aD,K,t,N,r;R();R=function(){};az=ap.get("has permission");U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");aB=new v.Schema({position:{type:"number",required:true},size:{type:"string",required:true},type:{type:"string",required:true,"default":"image"},content:{type:"mixed"},createdAt:{type:Date,"default":Date.now}});M=U.model("banners",aB);ag={hasPermission:az,query:M.find().sort("position")};l(F,M,ag,function(aQ,aR){if(aQ==="post"){return ap.get("data notify")("banners","Баннеры",aR)}});F.patch("/banners",function(aR,aQ){return az(aR.user,M.modelName,"write",function(aT){var aV,aU,aS;if(!aT){return aQ.send(403)}aS=[];aV={};aR.body.forEach(function(aW){return aV[aW._id]=aW});aU={_id:{$in:Object.keys(aV)}};return M.find(aU,function(aW,aY){var aX;if(aW){return aQ.send(500)}aY.forEach(function(a3){var a0,a2,a1,aZ;a1=aV[a3._id];aZ=[];for(a0 in a1){a2=a1[a0];aZ.push(a3[a0]=a2)}return aZ});aX=function(aZ,a0){return aZ.save(function(){aS.push(aZ);return a0()})};return f.forEachSeries(aY,aX,function(){return aQ.send(200,aS)})})})});R();U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");ac=new v.Schema({agency:{type:"string",required:true},phone:{type:"string",required:true},email:{type:"string",required:true},number:{type:"string",required:true},tourists:[String],createdAt:{type:Date,"default":Date.now},viewed:{type:Boolean,required:true,"default":false},processed:{type:Boolean,required:true,"default":false}});aM=U.model("certificates",ac);ag={hasPermission:ap.get("has permission"),query:aM.find().sort("-createdAt")};l(F,aM,ag,function(aQ,aR){if(aQ==="post"){ap.get("data notify")(aR)}if(aQ==="get"&&!aR.viewed){aR.viewed=true;return aR.save()}});R();U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");ae=new v.Schema({country:{type:"string",required:true},operator:{type:"string",required:true},description:{type:"string",required:true},price:{type:String,required:true},type:{type:String,"enum":["flights","transfers"],"default":"transfers",required:true},createdAt:{type:Date,"default":Date.now}});aj=U.model("charges",ae);ag={hasPermission:ap.get("has permission"),query:aj.find().sort("-createdAt")};l(F,aj,ag,function(aQ,aR){if(aQ==="post"){return ap.get("data notify")("charges","Доплаты",aR)}});R();U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");aP=new v.Schema({property:{type:"string",required:true},value:{type:"string",required:true}});ak=U.model("configs",aP);ag={hasPermission:ap.get("has permission"),query:ak.find()};l(F,ak,ag);R();U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");E=new v.Schema({email:{type:"string",required:true},comment:{type:"string"}});af=new v.Schema({name:{type:"string",required:true},lastname:{type:"string",required:true},responsibilities:Array,phone:{type:"string",required:true},emails:[I]});y=new v.Schema({name:{type:"string",required:true},email:{type:"string",required:true},phone:{type:"string"},schedule:{type:"string",required:true},employees:[af],createdAt:{type:Date,"default":Date.now}});ax=U.model("contacts",y);A=U.model("employees",af);I=U.model("employee-emails",E);ag={hasPermission:ap.get("has permission"),query:ax.find().sort("name")};l(F,ax,ag,function(aQ,aR){if(aQ==="post"){return ap.get("data notify")("contacts","Контакты",aR)}});R();U=ap.get("connection");v=ap.get("mongoose");ab=ap.get("data notify from");F=ap.get("app");ap.set("data notify",function(aZ,aW,aR){var aT,aU,aS,aY,aV,aQ;aV=ap.get("data notify emails path")||p.join(__dirname,"..","..","email");aS=ap.get("data notify emails")||{};aQ=ap.get("mailer transport");aT=function(a4){var a2,a0,a3,a1;a0="";for(a2 in a4){a3=a4[a2];if(a2[0]!=="_"){if(typeof a3==="object"&&(a3.isArray||{}.toString.call(a3)==="[object Array]")){a1=[];a3.forEach(function(a5){if(typeof a5==="string"){return a1.push(a5)}else{return a1.push(aT(a5))}});a0+=""+a2+": "+(a1.join(","))+"\n"}else{if(typeof a3==="object"){a0+=""+a2+": "+(aT(a3))+"\n"}else{a0+=""+a2+": "+a3+"\n"}}}}return a0};if(!aS[aZ]){return}ag={to:aS[aZ].join(","),from:ab,subject:aW};try{aY=j.readFileSync(""+aV+"/"+aZ+".jade");ag.html=d.compile(aY)(aR)}catch(aX){aU=aX;ag.text=aT(aR.toObject())}return aQ.sendMail(ag)});R();U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");Q=new v.Schema({email:{type:"string",required:true},organization:{type:"string",required:true},inn:{type:"string",required:true},numbers:{type:"string",required:true},address:{type:"string",required:true},createdAt:{type:Date,"default":Date.now},viewed:{type:Boolean,required:true,"default":false},processed:{type:Boolean,required:true,"default":false}});aa=U.model("documents",Q);ag={checkAuth:["list","get","put","delete"],query:aa.find().sort("-createdAt"),hasPermission:ap.get("has permission")};l(F,aa,ag,function(aQ,aR){if(aQ==="post"){ap.get("data notify")("documents-request","Бух. документы",aR)}if(aQ==="get"&&!aR.viewed){aR.viewed=true;return aR.save()}});R();U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");P=new v.Schema({country:{type:"string",required:true},name:{type:"string",required:true},description:{type:"string",required:true},duration:{type:String},transport:{type:String},place:{type:String},price:{type:String},images:Array,createdAt:{type:Date,"default":Date.now}});s=U.model("excursions",P);ag={hasPermission:ap.get("has permission"),query:s.find().sort("-name")};l(F,s,ag,function(aQ,aR){if(aQ==="post"){return ap.get("data notify")("excursions","Экскурсии",aR)}});R();az=ap.get("has permission");U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");u=new v.Schema({basename:{type:"string",required:true},path:{type:"string",required:true}});D=U.model("files",u);ag={hasPermission:az,actions:["list","delete"],query:D.find()};l(F,D,ag);Z=ap.get("application directory");at=p.join(Z,"public");at=ap.get("public directory",at);t=p.join(at,"uploads");t=ap.get("uploads directory",t);aw=t.replace(at,"");K=m.createFileUpload(t).middleware;F.post("/files",K,function(aR,aQ){return az(aR.user,D.modelName,"create",function(aS){var aT;if(!aS){return aQ.send(403)}aT=[];aR.body.files.forEach(function(aU){aU.path=""+aw+"/"+aU.path+aU.basename;(new D(aU)).save();return aT.push(aU)});return aQ.send({files:aT})})});R();az=ap.get("has permission");U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");aI=new v.Schema({name:{type:"string",required:true},code:{type:"string",required:true},description:{type:"string",required:true},createdAt:{type:Date,"default":Date.now}});aA=U.model("form-descriptions",aI);ag={hasPermission:az,actions:["list","post","delete"],query:aA.find().sort("name")};l(F,aA,ag,function(aQ,aR){if(aQ==="post"){return ap.get("data notify")("form-description","Описание форм",aR)}});F.get("/form-descriptions/:code",function(aR,aQ){return az(aR.user,aA.modelName,"read",function(aS){if(!aS){return aQ.send(403)}return aA.findOne({code:aR.params.code},function(aT,aU){if(aT){return aQ.send(500)}if(!aU){return aQ.send(404)}return aQ.send(aU)})})});F.put("/form-descriptions/:code",function(aR,aQ){return az(aR.user,aA.modelName,"write",function(aS){var aT;if(!aS){return aQ.send(403)}aT=aR.body;if(aT._id){delete aT._id}return aA.findOne({code:aR.params.code},function(aU,aV){if(aU){return aQ.send(500)}if(!aV){return aQ.send(404)}if(aT.description){aV.description=aT.description}return aV.save(function(aW){if(aW){return aQ.send(500)}aQ.set("Location",aR.url);return aQ.send(200,aV)})})})});R();U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");C=new v.Schema({name:{type:"string",require:true},description:{type:"string"}});J=new v.Schema({name:{type:"string",required:true},category:{type:"string"},description:{type:"string"},country:{type:"string",required:true},region:{type:"string"},rooms:[C],services:{type:Array},infrastructure:{type:Array},locationDescription:{type:"string"},location:{type:Array},adress:{type:"string"},phone:{type:"string"},fax:{type:"string"},email:{type:"string"},site:{type:"string"},images:Array,samo:{type:"string"},_export:{type:v.Schema.Types.Mixed},createdAt:{type:Date,"default":Date.now}});q=U.model("hotels",J);am=U.model("rooms",C);aD={mow:2,kuf:42,kzn:48,rov:64,svx:70,led:80,ufa:116};S={tr:10,eg:6,th:8,mv:249,"do":311,cu:23,lk:25,ae:26,"in":9,gr:4,es:5,it:70,tn:114,bg:3,cy:51};aq=/ehtml\('(.+)'\); if \(typeof/;F.get("/hotels/:id/prices/:town",function(aS,aR){var aT,aQ;aT="hotel-price:"+aS.params.id+":"+aS.params.town;aQ=b.get(aT);if(aQ){return aR.send(aQ.code,aQ.response)}return q.findOne({_id:aS.params.id},function(aX,aZ){var a0,a1,aV,aY,a2,aU,aW;if(aX){return aR.send(500)}if(!aZ.samo||!aD[aS.params.town]){b.put(aT,{code:404},3600000);return aR.send(404)}aU=aD[aS.params.town];aV=S[aZ.country];a1="20130812";aY="20130825";ab=6;a2=14;a0=2;aW="http://polartour.ru/samo/search_tour?samo_action=PRICES&TOWNFROMINC="+aU+"&CHECKIN_BEG="+a1+"&NIGHTS_FROM="+ab+"&CHECKIN_END="+aY+"&NIGHTS_TILL="+a2+"&ADULT="+a0+"&HOTELS="+aZ.samo+"&CURRENCY=1&STATEINC="+aV;return g.get(aW).end(function(a4,a3){var a5;if(a4){b.put(aT,{code:500},300000);return aR.send(500)}if(!a3.text.match(aq)){b.put(aT,{code:404},3600000);return aR.send(404)}a5=aq.exec(a3.text);a5=a5[1];a5=a5.replace(/\\n\\/g,"\n");a5=a5.replace(/\\"/g,'"');return c.env({html:a5,scripts:["http://code.jquery.com/jquery.js"],done:function(ba,a9){var a6,a8,a7;if(ba){b.put(aT,{code:500},300000);return aR.send(500)}a8=a9.$("tbody tr:eq(0) td:eq(8)").text().trim().split(" ");if(a8.length!==2){b.put(aT,{code:500},300000);return aR.send(500)}a6=a9.$("tbody tr:eq(0) td:eq(2)").text().trim();a7={price:Number(a8[0]),nights:a6,adults:a0,url:aW.replace("samo_action=PRICES&","")+"&DOLOAD=1"};b.put(aT,{code:200,response:a7},3600000);return aR.send(a7)}})})})});F.get("/hotels",function(aR,aQ){return q.find({},"_id name category country region").sort("name").find(aR.query).exec(function(aS,aT){if(aS){return aQ.send(500)}return q.find().distinct("country",function(aV,aU){var aW;if(aV){return aQ.send(500)}aW=[];aU.forEach(function(aX){return aW.push("/hotels?country="+aX+"; rel=subsection")});aQ.set("Link",aW);return aQ.send(aT)})})});ag={hasPermission:ap.get("has permission"),bindParams:true,query:q.find().sort("name")};l(F,q,ag,function(aQ,aR){if(aQ==="post"){return ap.get("data notify")("hotels","Отели",aR)}});R();az=ap.get("has permission");U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");z=new v.Schema({name:{type:"string",required:true},href:{type:"string",required:true},newWindow:{type:Boolean,"default":false},position:{type:"number",required:true,"default":0},active:{type:Boolean,"default":true}});G=new v.Schema({name:{type:"string",required:true},href:{type:"string",required:true},type:{type:"string",required:true},position:{type:"number",required:true,"default":0},newWindow:{type:Boolean,"default":false},active:{type:Boolean,"default":true},submenu:[z],createdAt:{type:Date,"default":Date.now}});V=U.model("menu",G);ag={hasPermission:az,query:V.find().sort({position:"ascending"})};l(F,V,ag,function(aQ,aR){if(aQ==="post"){return ap.get("data notify")("menu","Меню",aR)}});F.patch("/menu",function(aR,aQ){return az(aR.user,V.modelName,"write",function(aT){var aV,aU,aS;if(!aT){return aQ.send(403)}aS=[];aV={};aR.body.forEach(function(aW){if(aW._id){return aV[aW._id]=aW}else{return(new V(aW)).save(function(aX,aY){if(!aX){return aS.push(aY)}})}});aU={_id:{$in:Object.keys(aV)}};return V.find(aU,function(aW,aY){var aX;if(aW){return aQ.send(500)}aY.forEach(function(aZ){var a0;a0=aV[aZ._id];aZ.position=a0.position;aZ.href=a0.href;aZ.name=a0.name;aZ.newWindow=a0.newWindow;aZ.active=a0.active;return aZ.submenu=a0.submenu});aX=function(aZ,a0){return aZ.save(function(){aS.push(aZ);return a0()})};return f.forEachSeries(aY,aX,function(){return aQ.send(200,aS)})})})});R();U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");H=new v.Schema({title:{type:"string",required:true},description:{type:"string",required:true},body:{type:"string",required:true},createdAt:{type:Date,"default":Date.now},startAt:{type:Date,"default":Date.now},important:Boolean});aL=U.model("news",H);ag={hasPermission:ap.get("has permission"),query:aL.find().sort("-createdAt")};l(F,aL,ag,function(aQ,aR){if(aQ==="post"){return ap.get("data notify")("news","Новости",aR)}});R();U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");W=new v.Schema({name:{type:"string",required:true},description:{type:"string",required:true},href:{type:"string",required:true},createdAt:{type:Date,"default":Date.now}});L=U.model("pages",W);ag={hasPermission:ap.get("has permission"),query:L.find()};l(F,L,ag,function(aQ,aR){if(aQ==="post"){return ap.get("data notify")("pages","Страницы",aR)}});R();U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");aJ=new v.Schema({name:{type:"string",required:true},identity:{type:"string",required:true},read:{type:Boolean,"default":false},write:{type:Boolean,"default":false},create:{type:Boolean,"default":false},"delete":{type:Boolean,"default":false}});aN=new v.Schema({name:{type:"string",required:true},users:Array,permissions:[aJ]});ah=U.model("permissions",aJ);B=U.model("groups",aN);ao=U.model("users");F.use(function(aS,aR,aT){var aQ;aQ=aS.user?aS.user.username:"anonym";return B.find({users:aQ},function(aU,aV){if(aU){return aT()}return aT()})});ap.set("has permission",function(aT,aS,aR,aU){var aQ;if(!aT){aT="anonym"}if(aT.username){aT=aT.username}return aQ=B.find({users:aT},function(aX,aV){var aW;if(aX){return aU(false)}aW=false;aV.forEach(function(aY){return aY.permissions.forEach(function(aZ){if(aZ.identity===aS){if(aZ[aR]){return aW=true}}})});return aU(aW)})});R();U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");au=new v.Schema({name:{type:"string",required:true},phones:[String],createdAt:{type:Date,"default":Date.now}});O=U.model("phones",au);ag={hasPermission:ap.get("has permission"),query:O.find().sort("-name")};l(F,O,ag,function(aQ,aR){if(aQ==="post"){return ap.get("data notify")("phones","Телефоны",aR)}});R();av=ap.get("rates refresh interval",600000);X=ap.get("logger");F=ap.get("app");N=ap.get("rates url","http://polartour.ru/samo/default.php?page=currency");aO=ap.get("rates host");T=ap.get("rates port",1433);r=ap.get("rates username");aC=ap.get("rates password");aK=ap.get("rates client","mssql");ad=(function(){switch(aK){case"mssql":return new a(aO,T,r,aC);default:return new e(N)}})();an=true;(ay=function(){X.info("refreshing rates");return ad.refresh(function(aS,aZ){var aX,aV,aR,aQ,aY,aT,aW,aU;if(an){an=false;R()}if(aS){aQ=60000;aY="rates refreshing failed"}else{aQ=av;aY="rates refreshing succeed";for(aR in aZ.rates){aX=[];aU=aZ.currencies;for(aT=0,aW=aU.length;aT<aW;aT++){aV=aU[aT];aX.push(""+aV+"="+aZ.rates[aR][aV])}X.info("rates for "+aR,aX.join(", "))}}X.info(aY,"retry in "+(aQ/1000)+"s");return setTimeout(ay,aQ)})})();F.get("/rates",function(aR,aQ){if(ad.result){return aQ.send(ad.result)}else{return aQ.send(500)}});U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");ar=new v.Schema({name:{type:"string",required:true},email:{type:"string",required:true},message:{type:"string",required:true},createdAt:{type:Date,"default":Date.now},viewed:{type:Boolean,required:true,"default":false},processed:{type:Boolean,required:true,"default":false}});aG=U.model("reports",ar);ag={hasPermission:ap.get("has permission"),query:aG.find().sort("-createdAt")};l(F,aG,ag,function(aQ,aR){if(aQ==="post"){ap.get("data notify")("reports","Отзывы",aR)}if(aQ==="get"&&!aR.viewed){aR.viewed=true;return aR.save()}});R();U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");al=new v.Schema({gender:{type:"string",required:true,"default":"male"},fio:{type:"string",required:true},birthday:{type:"string",required:true},series:{type:"string",required:true},number:{type:"string",required:true},validity:{type:Date,required:true},date:{type:Date,required:true},who:{type:"string",required:true},citizenship:{type:"string",required:true}});aH=new v.Schema({city:{type:"string",required:true},agency:{type:"string",required:true},phone:{type:"string",required:true},email:{type:"string",required:true},address:{type:"string",required:true},departure:{type:"string",required:true},country:{type:"string",required:true},tour:{type:"string",required:true},hotel:{type:"string",required:true},placing:{type:"string",required:true},dateFrom:{type:Date},dateTo:{type:Date},nights:{type:"number"},count:{type:"number",required:true},price:{type:"number",required:true},number:{type:"string",required:true},tourists:[al],comment:{type:"string"},createdAt:{type:Date,"default":Date.now},viewed:{type:Boolean,required:true,"default":false},processed:{type:Boolean,required:true,"default":false}});aE=U.model("reservations",aH);ag={hasPermission:ap.get("has permission"),query:aE.find().sort("-createdAt")};l(F,aE,ag,function(aQ,aR){if(aQ==="post"){ap.get("data notify")("reservations","Заявки на бронь",aR)}if(aQ==="get"&&!aR.viewed){aR.viewed=true;return aR.save()}});R();U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");Y=new v.Schema({email:{type:"string",required:true},createdAt:{type:Date,"default":Date.now},viewed:{type:Boolean,required:true,"default":false},processed:{type:Boolean,required:true,"default":false}});w=U.model("subscriptions",Y);ai=U.model("users");F.get("/subscriptions/export",function(aR,aQ){return ai.findOne({"tokens.hash":aR.param("token")},function(aU,aT){var aS;if(aU){return aQ.send(401)}if(!aT){return aQ.send(401)}aS=o.first(o.filter(aT.tokens,function(aV){return aV.hash===aR.param("token")}));if(!aS){return aQ.send(401)}if(new Date>aS.expires){return aQ.send(401)}return w.find(function(aW,aX){var aV;if(aW){return aQ.send(500)}aV="";(aX||[]).forEach(function(a0){var aZ,a2,aY,a1;aY=[];a1=a0.toObject();for(aZ in a1){a2=a1[aZ];if(aZ[0]!=="_"){aY.push(a2)}}aV+=aY.join(",");return aV+="\r\n"});aQ.setHeader("Content-Type","text/csv");return aQ.send(aV)})})});ag={hasPermission:ap.get("has permission"),query:w.find().sort("-createdAt")};l(F,w,ag,function(aS,aT){var aR,aQ;if(aS==="post"){ap.get("data notify")("subscriptions","Подписки",aT);aR=ap.get("unisender key");if(!aR){return}aQ=new h(aR);aQ.subscribe(aT.email)}if(aS==="get"&&!aT.viewed){aT.viewed=true;return aT.save()}});R();U=ap.get("connection");v=ap.get("mongoose");F=ap.get("app");x=new v.Schema({name:{type:"string",required:true},createdAt:{type:Date,"default":Date.now}});aF=U.model("towns",x);ag={hasPermission:ap.get("has permission"),query:aF.find()};l(F,aF,ag,function(aQ,aR){if(aQ==="post"){return ap.get("data notify")("towns","Новый город",aR)}});return R()}}).call(this);