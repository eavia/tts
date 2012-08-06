function getPsnInfo_ByReadCard(dbpage, WINname) {  //读卡统一接口函数

    var features =
		'dialogWidth:' + 510 + 'px;' +
		'dialogHeight:' + 310 + 'px;' +
		'dialogLeft:' + 200 + 'px;' +
		'dialogTop:' + 200 + 'px;' +
		'directories:no; localtion:no; menubar:no; status=no; toolbar=no;scrollbars:yes;Resizeable=no';

    var retval = window.showModalDialog(escape(dbpage), "getReturn", features);
    return retval;
}