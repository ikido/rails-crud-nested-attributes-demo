module ApplicationHelper

  def highlighted_link_to name, path, expected_controller_name
    class_name = controller_name == expected_controller_name ? 'active' : nil
    content_tag :li, class: class_name do
      link_to name, path
    end
  end

  def bootstrap_flash_for(flash_type)
    {
      alert: 'danger',
      notice: 'success'
    }[flash_type.to_sym] || flash_type.to_s
  end

end
