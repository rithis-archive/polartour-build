(function(){var b,f,d,i,g,c,a,j,e,h=function(k,l){return function(){return k.apply(l,arguments)}};i=require("cruder");d=require("async");i=require("cruder");i=require("cruder");i=require("cruder");c=require("jade");j=require("path");g=require("fs");i=require("cruder");i=require("cruder");i=require("cruder");i=require("cruder");i=require("cruder");d=require("async");i=require("cruder");i=require("cruder");i=require("cruder");i=require("cruder");a=require("jsdom");b=(function(){function k(l){this.url=l;this.result=null}k.prototype.refresh=function(m){var l=this;return a.env({url:this.url,scripts:["http://code.jquery.com/jquery.js"],done:function(p,o){var q,n;if(p){if(m){m(p)}return}if(o.document.innerHTML.indexOf("page not found")>=0){if(m){m(p)}return}n={currencies:[],rates:{}};q=o.$;q("thead td").each(function(){return n.currencies.push(q(this).text().trim())});q("tbody tr").each(function(){var r;r=q("th",this).text().trim();n.rates[r]={};return q("td",this).each(function(t){var s;s=n.currencies[t];return n.rates[r][s]=q(this).text().trim()})});l.result=n;if(m){return m(null,n)}}})};return k})();i=require("cruder");i=require("cruder");e=require("superagent");i=require("cruder");f=(function(){function k(l){this.key=l;this.getList=h(this.getList,this);this.subscribe=h(this.subscribe,this);this.call=h(this.call,this)}k.prototype.call=function(n,l,m){return e.get("http://api.unisender.com/ru/api/"+n+"?format=json&api_key="+this.key).query(l).end(m)};k.prototype.subscribe=function(l){var m=this;return this.getList(function(n){var o;o={list_ids:n,fields:{email:l}};return m.call("subscribe",o)})};k.prototype.getList=function(m){var l=this;return this.call("getLists",{},function(o){var p,n;n="polartour.ru";p=false;o.body.result.forEach(function(q){if(q.title===n){return p=q}});if(p){m(p.id)}return l.call("createList",{title:n},function(q){return m(q.body.result.id)})})};return k})();i=require("cruder");module.exports=function(Q,Y){var u,ab,n,x,l,S,ae,H,s,ak,al,p,G,F,an,U,V,v,R,r,y,z,ac,m,A,ap,ad,D,C,B,M,aa,ao,aj,ai,X,L,o,W,I,E,P,T,K,ag,Z,k,af,w,O,N,J,ah,am,t,q;Y();Y=function(){};af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");ab=new N.Schema({position:{type:"number",required:true},size:{type:"string",required:true},type:{type:"string",required:true,"default":"image"},content:{type:"mixed"},createdAt:{type:Date,"default":Date.now}});u=af.model("banners",ab);i(k,u,{query:u.find().sort("position")},function(aq,ar){if(aq==="post"){return Q.get("data notify")("banners","Баннеры",ar)}});k.patch("/banners",function(at,ar){var av,au,aq;aq=[];av={};at.body.forEach(function(aw){return av[aw._id]=aw});au={_id:{$in:Object.keys(av)}};return u.find(au,function(aw,ay){var ax;if(aw){return ar.send(500)}ay.forEach(function(aD){var aA,aC,aB,az;aB=av[aD._id];az=[];for(aA in aB){aC=aB[aA];az.push(aD[aA]=aC)}return az});ax=function(az,aA){return az.save(function(){aq.push(az);return aA()})};return d.forEachSeries(ay,ax,function(){return ar.send(200,aq)})})});Y();af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");x=new N.Schema({agency:{type:"string",required:true},phone:{type:"string",required:true},email:{type:"string",required:true},number:{type:"string",required:true},tourists:[String],createdAt:{type:Date,"default":Date.now},viewed:{type:Boolean,required:true,"default":false}});n=af.model("certificates",x);J={checkAuth:["list","get","put","delete"],query:n.find().sort("-createdAt")};i(k,n,J,function(aq,ar){if(aq==="post"){Q.get("data notify")(ar)}if(aq==="get"&&!ar.viewed){ar.viewed=true;return ar.save()}});Y();af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");S=new N.Schema({country:{type:"string",required:true},operator:{type:"string",required:true},description:{type:"string",required:true},price:{type:String,required:true},createdAt:{type:Date,"default":Date.now}});l=af.model("charges",S);i(k,l,{query:l.find().sort("-createdAt")},function(aq,ar){if(aq==="post"){return Q.get("data notify")("charges","Доплаты",ar)}});Y();af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");p=new N.Schema({email:{type:"string",required:true},comment:{type:"string"}});F=new N.Schema({name:{type:"string",required:true},lastname:{type:"string",required:true},responsibilities:Array,phone:{type:"string",required:true},emails:[al]});H=new N.Schema({name:{type:"string",required:true},email:{type:"string",required:true},phone:{type:"string"},schedule:{type:"string",required:true},employees:[F],createdAt:{type:Date,"default":Date.now}});ae=af.model("contacts",H);G=af.model("employees",F);al=af.model("employee-emails",p);i(k,ae,{query:ae.find().sort("name")},function(aq,ar){if(aq==="post"){return Q.get("data notify")("contacts","Контакты",ar)}});Y();af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");Q.set("data notify",function(aA,ax,ar){var au,av,at,az,aw,aq;aw=Q.get("data notify emails path")||j.join(__dirname,"..","..","email");at=Q.get("data notify emails")||{};aq=Q.get("mailer transport");au=function(aF){var aD,aB,aE,aC;aB="";for(aD in aF){aE=aF[aD];if(aD[0]!=="_"){if(typeof aE==="object"&&(aE.isArray||{}.toString.call(aE)==="[object Array]")){aC=[];aE.forEach(function(aG){if(typeof aG==="string"){return aC.push(aG)}else{return aC.push(au(aG))}});aB+=""+aD+": "+(aC.join(","))+"\n"}else{if(typeof aE==="object"){aB+=""+aD+": "+(au(aE))+"\n"}else{aB+=""+aD+": "+aE+"\n"}}}}return aB};if(!at[aA]){return}J={to:at[aA],subject:ax};try{az=g.readFileSync(""+aw+"/"+aA+".jade");J.html=c.compile(az)(ar)}catch(ay){av=ay;J.text=au(ar.toObject())}return aq.sendMail(J)});Y();af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");ak=new N.Schema({email:{type:"string",required:true},organization:{type:"string",required:true},inn:{type:"string",required:true},numbers:{type:"string",required:true},address:{type:"string",required:true},createdAt:{type:Date,"default":Date.now},viewed:{type:Boolean,required:true,"default":false}});s=af.model("documents",ak);J={checkAuth:["list","get","put","delete"],query:s.find().sort("-createdAt")};i(k,s,J,function(aq,ar){if(aq==="post"){Q.get("data notify")("documents-request","Бух. документы",ar)}if(aq==="get"&&!ar.viewed){ar.viewed=true;return ar.save()}});Y();af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");U=new N.Schema({country:{type:"string",required:true},name:{type:"string",required:true},description:{type:"string",required:true},duration:{type:String},transport:{type:String},place:{type:String},price:{type:String},images:Array,createdAt:{type:Date,"default":Date.now}});an=af.model("excursions",U);i(k,an,{query:an.find().sort("-name")},function(aq,ar){if(aq==="post"){return Q.get("data notify")("excursions","Экскурсии",ar)}});Y();af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");v=new N.Schema({name:{type:"string",required:true},code:{type:"string",required:true},description:{type:"string",required:true},createdAt:{type:Date,"default":Date.now}});V=af.model("form-descriptions",v);Z=["list","post","delete"];i(k,V,{query:V.find().sort("name"),actions:Z},function(aq,ar){if(aq==="post"){return Q.get("data notify")("form-description","Описание форм",ar)}});k.get("/form-descriptions/:code",function(ar,aq){return V.findOne({code:ar.params.code},function(at,au){if(at){return aq.send(500)}if(!au){return aq.send(404)}return aq.send(au)})});k.put("/form-descriptions/:code",function(ar,aq){var at;at=ar.body;if(at._id){delete at._id}return V.findOne({code:ar.params.code},function(au,av){if(au){return aq.send(500)}if(!av){return aq.send(404)}if(at.description){av.description=at.description}return av.save(function(aw){if(aw){return aq.send(500)}aq.set("Location",ar.url);return aq.send(200,av)})})});Y();af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");o=new N.Schema({name:{type:"string",require:true},description:{type:"string"}});z=new N.Schema({name:{type:"string",required:true},category:{type:"string",required:true},description:{type:"string",required:true},country:{type:"string",required:true},region:{type:"string",required:true},rooms:[o],services:{type:Array},infrastructure:{type:Array},locationDescription:{type:"string",required:true},location:{type:Array},adress:{type:"string"},phone:{type:"string"},fax:{type:"string"},email:{type:"string"},site:{type:"string"},images:Array,samo:{type:"string"},createdAt:{type:Date,"default":Date.now}});y=af.model("hotels",z);L=af.model("rooms",o);i(k,y,{query:y.find().sort("name"),bindParams:true},function(aq,ar){if(aq==="post"){return Q.get("data notify")("hotels","Отели",ar)}});Y();af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");W=new N.Schema({name:{type:"string",required:true},href:{type:"string",required:true},newWindow:{type:Boolean,"default":false},position:{type:"number",required:true,"default":0},active:{type:Boolean,"default":true}});m=new N.Schema({name:{type:"string",required:true},href:{type:"string",required:true},type:{type:"string",required:true},position:{type:"number",required:true,"default":0},newWindow:{type:Boolean,"default":false},active:{type:Boolean,"default":true},submenu:[W],createdAt:{type:Date,"default":Date.now}});ac=af.model("menu",m);i(k,ac,{query:ac.find().sort({position:"ascending"},function(aq,ar){if(aq==="post"){return Q.get("data notify")("menu","Меню",ar)}})});k.patch("/menu",function(at,ar){var av,au,aq;aq=[];av={};at.body.forEach(function(aw){return av[aw._id]=aw});au={_id:{$in:Object.keys(av)}};return ac.find(au,function(aw,ay){var ax;if(aw){return ar.send(500)}ay.forEach(function(az){var aA;aA=av[az._id];az.position=aA.position;az.href=aA.href;az.name=aA.name;az.newWindow=aA.newWindow;az.active=aA.active;return aA.submenu.forEach(function(aB){if(!aB._id){az.submenu.push(aB)}return az.submenu.forEach(function(aC){if(aB._id===aC._id.toString()){aC.position=aB.position;aC.href=aB.href;aC.name=aB.name;aC.newWindow=aB.newWindow;return aC.active=aB.active}})})});ax=function(az,aA){return az.save(function(){aq.push(az);return aA()})};return d.forEachSeries(ay,ax,function(){return ar.send(200,aq)})})});Y();af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");ap=new N.Schema({title:{type:"string",required:true},description:{type:"string",required:true},body:{type:"string",required:true},createdAt:{type:Date,"default":Date.now},startAt:{type:Date,"default":Date.now},important:Boolean});A=af.model("news",ap);i(k,A,{query:A.find().sort("-createdAt")},function(aq,ar){if(aq==="post"){return Q.get("data notify")("news","Новости",ar)}});Y();af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");D=new N.Schema({name:{type:"string",required:true},description:{type:"string",required:true},href:{type:"string",required:true},createdAt:{type:Date,"default":Date.now}});ad=af.model("pages",D);i(k,ad,{query:ad.find()},function(aq,ar){if(aq==="post"){return Q.get("data notify")("pages","Страницы",ar)}});Y();af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");B=new N.Schema({name:{type:"string",required:true}});r=new N.Schema({name:{type:"string",required:true},users:Array,permissions:Array});C=af.model("permissions",B);R=af.model("groups",r);ag=af.model("users");k.use(function(at,ar,au){var aq;aq=at.user?at.user.username:"anonym";return R.find({users:aq},function(av,aw){if(av){return au()}return au()})});i(k,C,{query:C.find()});i(k,R,{query:R.find()});i(k,ag,{query:ag.find()});Y();af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");aa=new N.Schema({name:{type:"string",required:true},phones:[String],createdAt:{type:Date,"default":Date.now}});M=af.model("phones",aa);i(k,M,{query:M.find().sort("-name")},function(aq,ar){if(aq==="post"){return Q.get("data notify")("phones","Телефоны",ar)}});Y();t=Q.get("rates refresh interval",600000);O=Q.get("logger");q=Q.get("rates url","http://polartour.ru/samo/default.php?page=currency");k=Q.get("app");ah=new b(q);w=true;(am=function(){O.info("refreshing rates");return ah.refresh(function(at,aA){var ay,aw,ar,aq,az,au,ax,av;if(w){w=false;Y()}if(at){aq=60000;az="rates refreshing failed"}else{aq=t;az="rates refreshing succeed";for(ar in aA.rates){ay=[];av=aA.currencies;for(au=0,ax=av.length;au<ax;au++){aw=av[au];ay.push(""+aw+"="+aA.rates[ar][aw])}O.info("rates for "+ar,ay.join(", "))}}O.info(az,"retry in "+(aq/1000)+"s");return setTimeout(am,aq)})})();k.get("/rates",function(ar,aq){if(ah.result){return aq.send(ah.result)}else{return aq.send(500)}});af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");aj=new N.Schema({name:{type:"string",required:true},email:{type:"string",required:true},message:{type:"string",required:true},createdAt:{type:Date,"default":Date.now},viewed:{type:Boolean,required:true,"default":false}});ao=af.model("reports",aj);J={checkAuth:["list","get","put","delete"],query:ao.find().sort("-createdAt")};i(k,ao,J,function(aq,ar){if(aq==="post"){Q.get("data notify")("reports","Отзывы",ar)}if(aq==="get"&&!ar.viewed){ar.viewed=true;return ar.save()}});Y();af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");P=new N.Schema({gender:{type:"string",required:true,"default":"male"},fio:{type:"string",required:true},birthday:{type:"string",required:true},series:{type:"string",required:true},number:{type:"string",required:true},validity:{type:Date,required:true},date:{type:Date,required:true},who:{type:"string",required:true},citizenship:{type:"string",required:true}});X=new N.Schema({city:{type:"string",required:true},agency:{type:"string",required:true},phone:{type:"string",required:true},email:{type:"string",required:true},address:{type:"string",required:true},departure:{type:"string",required:true},country:{type:"string",required:true},tour:{type:"string",required:true},hotel:{type:"string",required:true},placing:{type:"string",required:true},dateFrom:{type:Date},dateTo:{type:Date},nights:{type:"number"},count:{type:"number",required:true},price:{type:"number",required:true},number:{type:"string",required:true},tourists:[P],comment:{type:"string",required:true},createdAt:{type:Date,"default":Date.now},viewed:{type:Boolean,required:true,"default":false}});ai=af.model("reservations",X);J={checkAuth:["list","get","put","delete"],query:ai.find().sort("-createdAt")};i(k,ai,J,function(aq,ar){if(aq==="post"){Q.get("data notify")("reservations","Заявки на бронь",ar)}if(aq==="get"&&!ar.viewed){ar.viewed=true;return ar.save()}});Y();af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");E=new N.Schema({email:{type:"string",required:true},createdAt:{type:Date,"default":Date.now},viewed:{type:Boolean,required:true,"default":false}});I=af.model("subscriptions",E);k.get("/subscriptions/export",function(ar,aq){if(!ar.user){return aq.send(401)}return I.find(function(au,av){var at;if(au){return aq.send(500)}at="";(av||[]).forEach(function(ay){var ax,aA,aw,az;aw=[];az=ay.toObject();for(ax in az){aA=az[ax];if(ax[0]!=="_"){aw.push(aA)}}at+=aw.join(",");return at+="\r\n"});aq.setHeader("Content-Type","text/csv");return aq.send(at)})});J={checkAuth:["list","get","put","delete"],query:I.find().sort("-createdAt")};i(k,I,J,function(at,au){var ar,aq;if(at==="post"){Q.get("data notify")("subscriptions","Подписки",au);ar=Q.get("unisender key");if(!ar){return}aq=new f(ar);aq.subscribe(au.email)}if(at==="get"&&!au.viewed){au.viewed=true;return au.save()}});Y();af=Q.get("connection");N=Q.get("mongoose");k=Q.get("app");K=new N.Schema({name:{type:"string",required:true},createdAt:{type:Date,"default":Date.now}});T=af.model("towns",K);i(k,T,{query:T.find()},function(aq,ar){if(aq==="post"){return Q.get("data notify")("towns","Новый город",ar)}});return Y()}}).call(this);