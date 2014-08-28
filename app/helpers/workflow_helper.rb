module WorkflowHelper

  def workflow_stage_class(workflow_stage)
    if workflow_stage == @assignment.current_workflow_stage
      'list-group-item-info'
    elsif workflow_stage.completed?
      "list-group-item-success"
    elsif workflow_stage.cancelled?
      "list-group-item-danger"
    end
  end

  def workflow_stage_icon(workflow_stage)
    if workflow_stage == @assignment.current_workflow_stage
      "glyphicon-star"
    elsif workflow_stage.completed?
      "glyphicon-chevron-right"
    elsif workflow_stage.cancelled?
      "glyphicon-remove"
    end
  end
end