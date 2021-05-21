
function fgridChart(historyDatas) {
	/* chart.js 구현 코드 */
	//<![CDATA[

	$(function() {
		jQuery('#grid').jqGrid('clearGridData')
		jQuery('#grid').jqGrid('setGridParam', { data: historyDatas, page: 1 })
		jQuery('#grid').trigger('reloadGrid');
	})

	$(function() {
		"use strict";
		$("#grid").jqGrid({
			colModel: [{
				name: "Email"
			}, {
				name: "Accessed"
			}, {
				name: "Date"
			}],
			data: historyDatas
		});
		$("#grid").jqGrid('setColWidth', 'Email', 260, false);
	});
}