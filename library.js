(function(){var d,a,g,e,k,m,l,i,c,b,n,f,h,j=function(o,p){return function(){return o.apply(p,arguments)}};k=require("cruder");e=require("async");k=require("cruder");k=require("cruder");k=require("cruder");k=require("cruder");c=require("jade");n=require("path");i=require("fs");k=require("cruder");k=require("cruder");l=require("fileupload");k=require("cruder");n=require("path");k=require("cruder");k=require("cruder");k=require("cruder");e=require("async");k=require("cruder");k=require("cruder");k=require("cruder");k=require("cruder");m=require("dateformat");b=require("jsdom");h=require("tds");d=(function(){function o(p){this.url=p;this.result=null}o.prototype.refresh=function(q){var p=this;return b.env({url:this.url,scripts:["http://code.jquery.com/jquery.js"],done:function(t,s){var u,r;if(t){q(t);return}if(s.document.innerHTML.indexOf("page not found")>=0){q("page not found");return}r={currencies:[],rates:{}};u=s.$;u("thead td").each(function(){return r.currencies.push(u(this).text().trim())});u("tbody tr").each(function(){var v;v=u("th",this).text().trim();r.rates[v]={};return u("td",this).each(function(x){var w;w=r.currencies[x];return r.rates[v][w]=u(this).text().trim()})});p.result=r;return q(null,r)}})};return o})();a=(function(){function o(r,p,s,q){this.host=r;this.port=p;this.username=s;this.password=q;this.result=null;this.connection=null}o.prototype.refresh=function(r){var p,q=this;if(this.connection){return this._refresh(r)}else{p=new h.Connection({host:this.host,port:this.port,userName:this.username,password:this.password});return p.connect(function(s){if(s){return r(s)}else{q.connection=p;q.connection.on("error",function(){q.connection.end();return q.connection=null});return q._refresh(r)}})}};o.prototype._refresh=function(t){var q,p,r,s=this;q=m("dd.mm.yyyy");p={currencies:[],rates:{}};p.rates[q]={};r=this.connection.createStatement("EXEC up_WEB_3_job_currency");r.on("row",function(v){var x,u,w;u=v.getValue("rate");x=v.getValue("alias_from");w=v.getValue("alias_to");if(w==="RUB"){if(p.currencies.indexOf(x)===-1){p.currencies.push(x);return p.rates[q][x]=u}}});r.on("done",function(){s.result=p;return t(null,p)});return r.execute()};return o})();k=require("cruder");k=require("cruder");f=require("superagent");k=require("cruder");g=(function(){function o(p){this.key=p;this.getList=j(this.getList,this);this.subscribe=j(this.subscribe,this);this.call=j(this.call,this)}o.prototype.call=function(r,p,q){return f.get("http://api.unisender.com/ru/api/"+r+"?format=json&api_key="+this.key).query(p).end(q)};o.prototype.subscribe=function(p){var q=this;return this.getList(function(r){var s;s={list_ids:r,fields:{email:p}};return q.call("subscribe",s)})};o.prototype.getList=function(q){var p=this;return this.call("getLists",{},function(s){var t,r;r="polartour.ru";t=false;s.body.result.forEach(function(u){if(u.title===r){return t=u}});if(t){q(t.id)}return p.call("createList",{title:r},function(u){return q(u.body.result.id)})})};return o})();k=require("cruder");module.exports=function(am,Q){var L,aw,aG,aa,ag,ac,ah,aJ,at,x,Y,P,H,D,z,ad,q,O,C,r,av,aC,A,aH,o,I,T,F,aF,G,K,U,af,aD,N,ap,aA,an,ay,aB,aj,B,y,v,W,ai,az,w,al,t,E,X,aE,S,ak,Z,aI,V,u,ae,ax,R,ar,ao,ab,au,aq,J,s,M,p;Q();Q=function(){};S=am.get("connection");u=am.get("mongoose");E=am.get("app");aw=new u.Schema({position:{type:"number",required:true},size:{type:"string",required:true},type:{type:"string",required:true,"default":"image"},content:{type:"mixed"},createdAt:{type:Date,"default":Date.now}});L=S.model("banners",aw);k(E,L,{query:L.find().sort("position")},function(aK,aL){if(aK==="post"){return am.get("data notify")("banners","Баннеры",aL)}});E.patch("/banners",function(aM,aL){var aO,aN,aK;aK=[];aO={};aM.body.forEach(function(aP){return aO[aP._id]=aP});aN={_id:{$in:Object.keys(aO)}};return L.find(aN,function(aP,aR){var aQ;if(aP){return aL.send(500)}aR.forEach(function(aW){var aT,aV,aU,aS;aU=aO[aW._id];aS=[];for(aT in aU){aV=aU[aT];aS.push(aW[aT]=aV)}return aS});aQ=function(aS,aT){return aS.save(function(){aK.push(aS);return aT()})};return e.forEachSeries(aR,aQ,function(){return aL.send(200,aK)})})});Q();S=am.get("connection");u=am.get("mongoose");E=am.get("app");aa=new u.Schema({agency:{type:"string",required:true},phone:{type:"string",required:true},email:{type:"string",required:true},number:{type:"string",required:true},tourists:[String],createdAt:{type:Date,"default":Date.now},viewed:{type:Boolean,required:true,"default":false}});aG=S.model("certificates",aa);ae={checkAuth:["list","get","put","delete"],query:aG.find().sort("-createdAt")};k(E,aG,ae,function(aK,aL){if(aK==="post"){am.get("data notify")(aL)}if(aK==="get"&&!aL.viewed){aL.viewed=true;return aL.save()}});Q();S=am.get("connection");u=am.get("mongoose");E=am.get("app");ac=new u.Schema({country:{type:"string",required:true},operator:{type:"string",required:true},description:{type:"string",required:true},price:{type:String,required:true},createdAt:{type:Date,"default":Date.now}});ag=S.model("charges",ac);k(E,ag,{query:ag.find().sort("-createdAt")},function(aK,aL){if(aK==="post"){return am.get("data notify")("charges","Доплаты",aL)}});Q();S=am.get("connection");u=am.get("mongoose");E=am.get("app");aJ=new u.Schema({property:{type:"string",required:true},value:{type:"string",required:true}});ah=S.model("configs",aJ);k(E,ah,{query:ah.find()});Q();S=am.get("connection");u=am.get("mongoose");E=am.get("app");D=new u.Schema({email:{type:"string",required:true},comment:{type:"string"}});ad=new u.Schema({name:{type:"string",required:true},lastname:{type:"string",required:true},responsibilities:Array,phone:{type:"string",required:true},emails:[H]});x=new u.Schema({name:{type:"string",required:true},email:{type:"string",required:true},phone:{type:"string"},schedule:{type:"string",required:true},employees:[ad],createdAt:{type:Date,"default":Date.now}});at=S.model("contacts",x);z=S.model("employees",ad);H=S.model("employee-emails",D);k(E,at,{query:at.find().sort("name")},function(aK,aL){if(aK==="post"){return am.get("data notify")("contacts","Контакты",aL)}});Q();S=am.get("connection");u=am.get("mongoose");Z=am.get("data notify from");E=am.get("app");am.set("data notify",function(aT,aQ,aL){var aN,aO,aM,aS,aP,aK;aP=am.get("data notify emails path")||n.join(__dirname,"..","..","email");aM=am.get("data notify emails")||{};aK=am.get("mailer transport");aN=function(aY){var aW,aU,aX,aV;aU="";for(aW in aY){aX=aY[aW];if(aW[0]!=="_"){if(typeof aX==="object"&&(aX.isArray||{}.toString.call(aX)==="[object Array]")){aV=[];aX.forEach(function(aZ){if(typeof aZ==="string"){return aV.push(aZ)}else{return aV.push(aN(aZ))}});aU+=""+aW+": "+(aV.join(","))+"\n"}else{if(typeof aX==="object"){aU+=""+aW+": "+(aN(aX))+"\n"}else{aU+=""+aW+": "+aX+"\n"}}}}return aU};if(!aM[aT]){return}ae={to:aM[aT].join(","),from:Z,subject:aQ};try{aS=i.readFileSync(""+aP+"/"+aT+".jade");ae.html=c.compile(aS)(aL)}catch(aR){aO=aR;ae.text=aN(aL.toObject())}return aK.sendMail(ae)});Q();S=am.get("connection");u=am.get("mongoose");E=am.get("app");P=new u.Schema({email:{type:"string",required:true},organization:{type:"string",required:true},inn:{type:"string",required:true},numbers:{type:"string",required:true},address:{type:"string",required:true},createdAt:{type:Date,"default":Date.now},viewed:{type:Boolean,required:true,"default":false}});Y=S.model("documents",P);ae={checkAuth:["list","get","put","delete"],query:Y.find().sort("-createdAt")};k(E,Y,ae,function(aK,aL){if(aK==="post"){am.get("data notify")("documents-request","Бух. документы",aL)}if(aK==="get"&&!aL.viewed){aL.viewed=true;return aL.save()}});Q();S=am.get("connection");u=am.get("mongoose");E=am.get("app");O=new u.Schema({country:{type:"string",required:true},name:{type:"string",required:true},description:{type:"string",required:true},duration:{type:String},transport:{type:String},place:{type:String},price:{type:String},images:Array,createdAt:{type:Date,"default":Date.now}});q=S.model("excursions",O);k(E,q,{query:q.find().sort("-name")},function(aK,aL){if(aK==="post"){return am.get("data notify")("excursions","Экскурсии",aL)}});Q();S=am.get("connection");u=am.get("mongoose");E=am.get("app");r=new u.Schema({basename:{type:"string",required:true},path:{type:"string",required:true}});C=S.model("files",r);k(E,C,{query:C.find(),actions:["list","delete"]});X=am.get("application directory");ao=n.join(X,"public");ao=am.get("public directory",ao);s=n.join(ao,"uploads");s=am.get("uploads directory",s);ar=s.replace(ao,"");J=l.createFileUpload(s).middleware;E.post("/files",J,function(aM,aK){var aL;aL=[];aM.body.files.forEach(function(aN){aN.path=""+ar+"/"+aN.path+aN.basename;(new C(aN)).save();return aL.push(aN)});return aK.send({files:aL})});Q();S=am.get("connection");u=am.get("mongoose");E=am.get("app");aC=new u.Schema({name:{type:"string",required:true},code:{type:"string",required:true},description:{type:"string",required:true},createdAt:{type:Date,"default":Date.now}});av=S.model("form-descriptions",aC);t=["list","post","delete"];k(E,av,{query:av.find().sort("name"),actions:t},function(aK,aL){if(aK==="post"){return am.get("data notify")("form-description","Описание форм",aL)}});E.get("/form-descriptions/:code",function(aL,aK){return av.findOne({code:aL.params.code},function(aM,aN){if(aM){return aK.send(500)}if(!aN){return aK.send(404)}return aK.send(aN)})});E.put("/form-descriptions/:code",function(aL,aK){var aM;aM=aL.body;if(aM._id){delete aM._id}return av.findOne({code:aL.params.code},function(aN,aO){if(aN){return aK.send(500)}if(!aO){return aK.send(404)}if(aM.description){aO.description=aM.description}return aO.save(function(aP){if(aP){return aK.send(500)}aK.set("Location",aL.url);return aK.send(200,aO)})})});Q();S=am.get("connection");u=am.get("mongoose");E=am.get("app");B=new u.Schema({name:{type:"string",require:true},description:{type:"string"}});I=new u.Schema({name:{type:"string",required:true},category:{type:"string"},description:{type:"string"},country:{type:"string",required:true},region:{type:"string"},rooms:[B],services:{type:Array},infrastructure:{type:Array},locationDescription:{type:"string"},location:{type:Array},adress:{type:"string"},phone:{type:"string"},fax:{type:"string"},email:{type:"string"},site:{type:"string"},images:Array,samo:{type:"string"},_export:{type:u.Schema.Types.Mixed},createdAt:{type:Date,"default":Date.now}});o=S.model("hotels",I);aj=S.model("rooms",B);E.get("/hotels",function(aL,aK){return o.find().sort("name").find(aL.query).exec(function(aM,aN){if(aM){return aK.send(500)}return o.find().distinct("country",function(aP,aO){var aQ;if(aP){return aK.send(500)}aQ=[];aO.forEach(function(aR){return aQ.push("/hotels?country="+aR+"; rel=subsection")});aK.set("Link",aQ);return aK.send(aN)})})});k(E,o,{query:o.find().sort("name"),bindParams:true},function(aK,aL){if(aK==="post"){return am.get("data notify")("hotels","Отели",aL)}});Q();S=am.get("connection");u=am.get("mongoose");E=am.get("app");y=new u.Schema({name:{type:"string",required:true},href:{type:"string",required:true},newWindow:{type:Boolean,"default":false},position:{type:"number",required:true,"default":0},active:{type:Boolean,"default":true}});F=new u.Schema({name:{type:"string",required:true},href:{type:"string",required:true},type:{type:"string",required:true},position:{type:"number",required:true,"default":0},newWindow:{type:Boolean,"default":false},active:{type:Boolean,"default":true},submenu:[y],createdAt:{type:Date,"default":Date.now}});T=S.model("menu",F);k(E,T,{query:T.find().sort({position:"ascending"},function(aK,aL){if(aK==="post"){return am.get("data notify")("menu","Меню",aL)}})});E.patch("/menu",function(aM,aL){var aO,aN,aK;aK=[];aO={};aM.body.forEach(function(aP){if(aP._id){return aO[aP._id]=aP}else{return(new T(aP)).save(function(aQ,aR){if(!aQ){return aK.push(aR)}})}});aN={_id:{$in:Object.keys(aO)}};return T.find(aN,function(aP,aR){var aQ;if(aP){return aL.send(500)}aR.forEach(function(aS){var aT;aT=aO[aS._id];aS.position=aT.position;aS.href=aT.href;aS.name=aT.name;aS.newWindow=aT.newWindow;aS.active=aT.active;return aS.submenu=aT.submenu});aQ=function(aS,aT){return aS.save(function(){aK.push(aS);return aT()})};return e.forEachSeries(aR,aQ,function(){return aL.send(200,aK)})})});Q();S=am.get("connection");u=am.get("mongoose");E=am.get("app");G=new u.Schema({title:{type:"string",required:true},description:{type:"string",required:true},body:{type:"string",required:true},createdAt:{type:Date,"default":Date.now},startAt:{type:Date,"default":Date.now},important:Boolean});aF=S.model("news",G);k(E,aF,{query:aF.find().sort("-createdAt")},function(aK,aL){if(aK==="post"){return am.get("data notify")("news","Новости",aL)}});Q();S=am.get("connection");u=am.get("mongoose");E=am.get("app");U=new u.Schema({name:{type:"string",required:true},description:{type:"string",required:true},href:{type:"string",required:true},createdAt:{type:Date,"default":Date.now}});K=S.model("pages",U);k(E,K,{query:K.find()},function(aK,aL){if(aK==="post"){return am.get("data notify")("pages","Страницы",aL)}});Q();S=am.get("connection");u=am.get("mongoose");E=am.get("app");aD=new u.Schema({name:{type:"string",required:true}});aH=new u.Schema({name:{type:"string",required:true},users:Array,permissions:Array});af=S.model("permissions",aD);A=S.model("groups",aH);al=S.model("users");E.use(function(aM,aL,aN){var aK;aK=aM.user?aM.user.username:"anonym";return A.find({users:aK},function(aO,aP){if(aO){return aN()}return aN()})});k(E,af,{query:af.find()});k(E,A,{query:A.find()});k(E,al,{query:al.find()});Q();S=am.get("connection");u=am.get("mongoose");E=am.get("app");ap=new u.Schema({name:{type:"string",required:true},phones:[String],createdAt:{type:Date,"default":Date.now}});N=S.model("phones",ap);k(E,N,{query:N.find().sort("-name")},function(aK,aL){if(aK==="post"){return am.get("data notify")("phones","Телефоны",aL)}});Q();aq=am.get("rates refresh interval",600000);V=am.get("logger");E=am.get("app");M=am.get("rates url","http://polartour.ru/samo/default.php?page=currency");aI=am.get("rates host");R=am.get("rates port",1433);p=am.get("rates username");ax=am.get("rates password");aE=am.get("rates client","mssql");ab=(function(){switch(aE){case"mssql":return new a(aI,R,p,ax);default:return new d(M)}})();ak=true;(au=function(){V.info("refreshing rates");return ab.refresh(function(aM,aT){var aR,aP,aL,aK,aS,aN,aQ,aO;if(ak){ak=false;Q()}if(aM){aK=60000;aS="rates refreshing failed"}else{aK=aq;aS="rates refreshing succeed";for(aL in aT.rates){aR=[];aO=aT.currencies;for(aN=0,aQ=aO.length;aN<aQ;aN++){aP=aO[aN];aR.push(""+aP+"="+aT.rates[aL][aP])}V.info("rates for "+aL,aR.join(", "))}}V.info(aS,"retry in "+(aK/1000)+"s");return setTimeout(au,aK)})})();E.get("/rates",function(aL,aK){if(ab.result){return aK.send(ab.result)}else{return aK.send(500)}});S=am.get("connection");u=am.get("mongoose");E=am.get("app");an=new u.Schema({name:{type:"string",required:true},email:{type:"string",required:true},message:{type:"string",required:true},createdAt:{type:Date,"default":Date.now},viewed:{type:Boolean,required:true,"default":false}});aA=S.model("reports",an);ae={checkAuth:["list","get","put","delete"],query:aA.find().sort("-createdAt")};k(E,aA,ae,function(aK,aL){if(aK==="post"){am.get("data notify")("reports","Отзывы",aL)}if(aK==="get"&&!aL.viewed){aL.viewed=true;return aL.save()}});Q();S=am.get("connection");u=am.get("mongoose");E=am.get("app");ai=new u.Schema({gender:{type:"string",required:true,"default":"male"},fio:{type:"string",required:true},birthday:{type:"string",required:true},series:{type:"string",required:true},number:{type:"string",required:true},validity:{type:Date,required:true},date:{type:Date,required:true},who:{type:"string",required:true},citizenship:{type:"string",required:true}});aB=new u.Schema({city:{type:"string",required:true},agency:{type:"string",required:true},phone:{type:"string",required:true},email:{type:"string",required:true},address:{type:"string",required:true},departure:{type:"string",required:true},country:{type:"string",required:true},tour:{type:"string",required:true},hotel:{type:"string",required:true},placing:{type:"string",required:true},dateFrom:{type:Date},dateTo:{type:Date},nights:{type:"number"},count:{type:"number",required:true},price:{type:"number",required:true},number:{type:"string",required:true},tourists:[ai],comment:{type:"string",required:true},createdAt:{type:Date,"default":Date.now},viewed:{type:Boolean,required:true,"default":false}});ay=S.model("reservations",aB);ae={checkAuth:["list","get","put","delete"],query:ay.find().sort("-createdAt")};k(E,ay,ae,function(aK,aL){if(aK==="post"){am.get("data notify")("reservations","Заявки на бронь",aL)}if(aK==="get"&&!aL.viewed){aL.viewed=true;return aL.save()}});Q();S=am.get("connection");u=am.get("mongoose");E=am.get("app");W=new u.Schema({email:{type:"string",required:true},createdAt:{type:Date,"default":Date.now},viewed:{type:Boolean,required:true,"default":false}});v=S.model("subscriptions",W);E.get("/subscriptions/export",function(aL,aK){if(!aL.user){return aK.send(401)}return v.find(function(aN,aO){var aM;if(aN){return aK.send(500)}aM="";(aO||[]).forEach(function(aR){var aQ,aT,aP,aS;aP=[];aS=aR.toObject();for(aQ in aS){aT=aS[aQ];if(aQ[0]!=="_"){aP.push(aT)}}aM+=aP.join(",");return aM+="\r\n"});aK.setHeader("Content-Type","text/csv");return aK.send(aM)})});ae={checkAuth:["list","get","put","delete"],query:v.find().sort("-createdAt")};k(E,v,ae,function(aM,aN){var aL,aK;if(aM==="post"){am.get("data notify")("subscriptions","Подписки",aN);aL=am.get("unisender key");if(!aL){return}aK=new g(aL);aK.subscribe(aN.email)}if(aM==="get"&&!aN.viewed){aN.viewed=true;return aN.save()}});Q();S=am.get("connection");u=am.get("mongoose");E=am.get("app");w=new u.Schema({name:{type:"string",required:true},createdAt:{type:Date,"default":Date.now}});az=S.model("towns",w);k(E,az,{query:az.find()},function(aK,aL){if(aK==="post"){return am.get("data notify")("towns","Новый город",aL)}});return Q()}}).call(this);