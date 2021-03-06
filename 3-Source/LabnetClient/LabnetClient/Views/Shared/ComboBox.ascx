﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<LabnetClient.Models.ComboBoxModel>" %>
<script type="text/javascript" src="../../Content/Lib/jquery-ui-1.8.16/jquery.ui.combobox.js"></script>
<script type="text/javascript">
    function <%= Model.ComboBoxId %>_ComboBoxSelect(id, label, tag)
    {
    }
    $(document).ready(function () {
        $.widget("ui.combobox", {
            _create: function () {
                var self = this,
					select = this.element.hide(),
					selected = select.children(":selected"),
                    // This line added to set default value of the combobox
					value = selected.val() ? selected.text().trim() : "";
                  var  input = this.input = $("<input id='<%= Model.ComboBoxId %>_text'>")
					.insertAfter(select)
					.val(value)
					.autocomplete({
					    delay: 0,
					    minLength: 0,
					    source: function (request, response) {
					        var matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), "i");
					        response(select.children("option").map(function () {
					            var text = $(this).text().trim();
					            var value = $(this).val();
					            var tag = $(this).attr("tag");
					            if (this.value && (!request.term || matcher.test(text)))
					                return {
					                    label: text.replace(
											new RegExp(
												"(?![^&;]+;)(?!<[^<>]*)(" +
												$.ui.autocomplete.escapeRegex(request.term) +
												")(?![^<>]*>)(?![^&;]+;)", "gi"
											), "<strong>$1</strong>"),
					                    value: text,
					                    id: value,
					                    tag: tag,
					                    option: this
					                };
					        }));
					    },
					    select: function (event, ui) {
					        $("#<%= Model.ComboBoxId %> .autoCompleteBindingValue").val(ui.item.id);
					        $("#<%= Model.ComboBoxId %>_SelectedValue").val(ui.item.id);
					        $("#<%= Model.ComboBoxId %>_SelectedText").val(ui.item.value);
					        $("#<%= Model.ComboBoxId %>_SelectedTag").val(ui.item.tag);
					        ui.item.option.selected = true;
					        self._trigger("selected", event, {
					            item: ui.item.option
					        });
					        <%= Model.ComboBoxId %>_ComboBoxSelect(ui.item.id,ui.item.value, ui.item.tag);
					    },
					    selectFirst: true,
					    change: function (event, ui) {
					        if (!ui.item) {
					            var matcher = new RegExp("^" + $.ui.autocomplete.escapeRegex($(this).val()) + "$", "i"),
									valid = false;
					            select.children("option").each(function () {
					                if ($(this).text().match(matcher)) {
					                    this.selected = valid = true;
					                    return false;
					                }
					            });
					            if (!valid) {
					                // remove invalid value, as it didn't match anything
					                $(this).val("");
					                select.val("");
					                input.data("autocomplete").term = "";
					                $("#<%= Model.ComboBoxId %> .autoCompleteBindingValue").val("");
					                $("#<%= Model.ComboBoxId %>_SelectedValue").val("");
					                $("#<%= Model.ComboBoxId %>_SelectedText").val("");
					                $("#<%= Model.ComboBoxId %>_SelectedTag").val("");
					                $("#<%= Model.ComboBoxId %>_text").data("autocomplete").term = "";
					                <%= Model.ComboBoxId %>_ComboBoxSelect("-1", "", "");
					                return false;
					            }
					        }
					    }
					})
					.addClass("ui-widget ui-widget-content ui-corner-left");
                    
                input.data("autocomplete")._renderItem = function (ul, item) {
                    return $("<li></li>")
						.data("item.autocomplete", item)
						.append("<a>" + item.label.trim() + "</a>")
						.appendTo(ul);
                };
                <%if(Model.IsEnabled){%>
                    this.button = $("<button type='button'>&nbsp;</button>")
                <%}else{ %>
                    this.button = $("<button type='button' disabled='disabled'>&nbsp;</button>")
                <%} %>
					.attr("tabIndex", -1)
					.attr("title", "Show All Items")
					.insertAfter(input)
					.button({
					    icons: {
					        primary: "ui-icon-triangle-1-s"
					    },
					    text: false
					})
					.removeClass("ui-corner-all")
					.addClass("ui-corner-right ui-button-icon")
					.click(function () {
					    // close if already visible
					    if (input.autocomplete("widget").is(":visible")) {
					        input.autocomplete("close");
					        return;
					    }

					    // work around a bug (likely same cause as #5265)
					    $(this).blur();

					    // pass empty string as value to search for, displaying all results
					    input.autocomplete("search", "");
					    input.focus();
					});
            },

            destroy: function () {
                this.input.remove();
                this.button.remove();
                this.element.show();
                $.Widget.prototype.destroy.call(this);
            }
        });
        
        $("#<%: Model.ComboBoxId %>").combobox();
        $("#<%= Model.ComboBoxId %>_text").addClass("ComboBox-input-ui");
        <%if(!Model.IsEnabled){ %>
           $("#<%: Model.ComboBoxId %>").combobox("option", "disabled", true);
        <%} %>
    });
</script>
<style type="text/css">
    .ComboBox-input-ui
    {
        padding: 6px;
        border-radius: 0px;
        margin: 0px 3px 0px 0px;
    }
    
    .ui-autocomplete
    {
        height: 200px;
        overflow-y: scroll;
        overflow-x: hidden;
    }
    .ui-menu-item a
    {
        height: 18px;
    }
</style>
<input type="hidden" class="autoCompleteBindingValue" value="<%= Model.SelectedValue %>"
    name="<%=Model.BindingName%>" />
<input type="hidden" class="autoCompleteTag" id="<%= Model.ComboBoxId %>_SelectedTag"
    value="<%= Model.SelectedTag %>" />
<input type="hidden" class="autoCompleteValue" id="<%= Model.ComboBoxId %>_SelectedValue"
    value="<%= Model.SelectedValue %>" />
<input type="hidden" class="autoCompleteText" id="<%= Model.ComboBoxId %>_SelectedText"
    value="<%= Model.SelectedText %>" />
<select id="<%: Model.ComboBoxId %>">
    <option value="-1" tag=""></option>
    <% foreach (var item in Model.ComboBoxData)
       { %>
    <%if (item.Value == Model.SelectedValue && (string.IsNullOrEmpty(Model.SelectedText) || Model.SelectedText == item.Label))
      { %>
    <option value="<%:item.Value%>" tag="<%:item.Tag%>" selected="selected">
        <%:item.Label.Trim()%></option>
    <%}
      else %>
    <%{ %>
    <option value="<%:item.Value%>" tag="<%:item.Tag%>">
        <%:item.Label.Trim()%></option>
    <%} %>
    <%} %>
</select>