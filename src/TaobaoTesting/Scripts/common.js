function getPsnInfo_ByReadCard(dbpage, WINname) {
     var features =
		'dialogWidth:' + 510 + 'px;' +
		'dialogHeight:' + 310 + 'px;' +
		'dialogLeft:' + 200 + 'px;' +
		'dialogTop:' + 200 + 'px;' +
		'directories:no; localtion:no; menubar:no; status=no; toolbar=no;scrollbars:yes;Resizeable=no';

    var retval = window.showModalDialog(escape(dbpage), "getReturn", features);
    return retval;
}

//判断分辨率是否大于800x600
//如果小于800x600 则 返回 0
//如果等于800x600 则 返回 1
//如果大于800x600 则 返回 2
function Is800x600() {

    if (window.screen.width == 800 && window.screen.height == 600) {
        return 1;
    }
    else {
        if (window.screen.width < 800 && window.screen.height < 600) {
            return 0;
        }
        else {
            return 2;
        }
    }
}