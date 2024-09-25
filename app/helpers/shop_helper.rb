module ShopHelper
  def image_upload_field(form, object, attribute, label_text)
    content_tag(:div, class: "row mb-3") do
      concat(
        content_tag(:div, class: "col-9") do
          concat form.label attribute, label_text
          concat form.file_field attribute, class: "form-control"
          concat form.hidden_field "#{attribute}_cache".to_sym
        end
      )
      
      concat(
        content_tag(:div, class: "col") do
          if object.send(attribute).present?
            concat image_tag(object.send(attribute).url, class: "img-fluid")
          elsif object.send("#{attribute}_cache").present?
            concat image_tag(object.send("#{attribute}_cache"), class: "img-fluid")
          else
            concat "お店ロゴが登録されていません。"
          end
        end
      )
    end
  end
end
