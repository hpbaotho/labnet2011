﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace DomainModel.JQGrid
{
    public class JQConstant
    {
        public const string columnTemplate = @" name: '{0}', index: '{1}', width: {2} , editable:{3}, edittype:'{4}',hidden:{5}, formatter:{6}, formatoptions:{7}";
        public const string EditOptions = @",editoptions: //Place this code in the col options of the last column in your grid  it listens for the tab button being pressed
        {{
            {0}
            dataEvents: [
                {{ 
                    type: 'keydown', 
                    fn: function(e) {{ 
                        var key = e.charCode || e.keyCode;
                        if(key == 9)   // tab
                        {{
                            var nextCol=0;
                            var colModels=jQuery('#list').jqGrid ('getGridParam', 'colModel');
                            for(var i=0;i<colModels.length;i++)
                            {{
                                if(colModels[i].editable===true &&colModels[i].hidden===false)
                                {{
                                    nextCol=i;
                                    break;
                                }}
                            }}
                            setTimeout(""$('#list').editCell("" + selRowIndex + "" + 1,"" +nextCol+"", true);"", 100);
                        }}
                    }}
                }} ]
        }}";
    }
}