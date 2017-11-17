class Gitlab::Client
  # Defines methods related to pipeline schedules and pipelines schedule variables.
  # @see https://docs.gitlab.com/ce/api/pipeline_schedules.html
  module PipelineSchedules
    # Get a list of the pipeline schedules of a project.
    #
    # @example
    #   Gitlab.pipeline_schedules(5)
    #   Gitlab.pipeline_schedules(5, { scope: 'active' })
    #
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :scope The scope of pipelines schedules, one of 'active' or 'inactive'
    # @return [Array<Gitlab::ObjectifiedHash>]
    def pipeline_schedules(project, options={})
      get("/projects/#{url_encode project}/pipeline_schedules", query: options)
    end

    # Gets a single pipeline schedule of a project.
    #
    # @example
    #   Gitlab.pipeline_schedule(5, 36)
    #
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Integer] id The ID of a pipeline_schedule.
    # @return [Gitlab::ObjectifiedHash]
    def pipeline_schedule(project, id)
      get("/projects/#{url_encode project}/pipeline_schedules/#{id}")
    end

    # Create a pipeline schedule for a project.
    #
    # @example
    #   Gitlab.create_pipeline_schedule(5, {description: "my description", ref: 'master', cron: "0 1 * * 5", cron_timezone: "UTC", active: true})
    #
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Hash] options A customizable set of options.
    # @option options  [String] description The description of pipeline schedule
    # @option options  [String] ref The branch/tag name will be triggered
    # @option options  [String] cron The cron (e.g. 0 1 * * *)
    # @option options  [String] cron_timezone The timezone supproted by ActiveSupport::TimeZone (e.g. Pacific Time (US & Canada)) (default: 'UTC') (not required)
    # @option options  [Boolean] active The activation of pipeline schedule. If false is set, the pipeline schedule will deactivated initially (default: true) (not required)
    # @return [Gitlab::ObjectifiedHash] The created pipeline schedule.
    def create_pipeline_schedule(project, options: {description: nil, ref: nil, cron: nil, cron_timezone: nil, active: nil})
      a = post("/projects/#{url_encode project}/pipeline_schedules", body: options)
      a.inspect
    end

    # Update a pipeline schedule for a project.
    #
    # @example
    #   Gitlab.update_pipeline_schedule(5, 13, description: "my description", ref: 'master', cron: "0 1 * * 5", cron_timezone: "UTC", active: true)
    #
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Integer] id The ID of a pipeline_schedule.
    # @param  [String] description The description of pipeline schedule
    # @param  [String] ref The branch/tag name will be triggered
    # @param  [String] cron The cron (e.g. 0 1 * * *)
    # @param  [String] cron_timezone The timezone supproted by ActiveSupport::TimeZone (e.g. Pacific Time (US & Canada)) (default: 'UTC') (not required)
    # @param  [Boolean] active The activation of pipeline schedule. If false is set, the pipeline schedule will deactivated initially (default: true) (not required)
    # @return [Gitlab::ObjectifiedHash] The updated pipeline schedule.
    def update_pipeline_schedule(project, id, description, ref, cron, cron_timezone, active)
      put("/projects/#{url_encode project}/pipeline_schedules/#{id}", body: {description: description, ref: ref, cron: cron, cron_timezone: cron_timezone, active: active})
    end

    # Take ownership of a pipeline schedule of a project.
    #
    # @example
    #   Gitlab.own_pipeline_schedule(5, 13)
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Integer] id The ID of a pipeline_schedule.
    # @return [Gitlab::ObjectifiedHash] The updated pipeline schedule.
    def own_pipeline_schedule(project, id)
      post("/projects/#{url_encode project}/pipeline_schedules/#{id}/take_ownership")
    end

    # Delete the pipeline schedule of a project.
    #
    # @example
    #   Gitlab.delete_pipeline_schedule(5, 13)
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Integer] id The ID of a pipeline_schedule.
    # @return [Gitlab::ObjectifiedHash]
    def delete_pipeline_schedule(project, id)
      delete("/projects/#{url_encode project}/pipeline_schedules/#{id}")
    end

    # Create a new variable of a pipeline schedule.
    #
    # @example
    #   Gitlab.create_pipeline_schedule_variable(5, 13, key: 'NEW_VARIABLE', value: 'new value')
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Integer] id The ID of a pipeline_schedule.
    # @param [String] key The key of a variable; must have no more than 255 characters; only A-Z, a-z, 0-9, and _ are allowed
    # @param [String] value The value of a variable
    # @return [Gitlab::ObjectifiedHash] The new pipeline schedule variable
    def create_pipeline_schedule_variable(project, id, key, value)
      post("/projects/#{url_encode project}/pipeline_schedules/#{id}/variables", body: {key: key, value: value})
    end

    # Update the variable of a pipeline schedule.
    #
    # @example
    #   Gitlab.edit_pipeline_schedule_variable(5, 13, key: 'NEW_VARIABLE', value: 'new value')
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Integer] id The ID of a pipeline_schedule.
    # @param [String] key The key of the variable
    # @param [String] value The new value of the variable
    # @return [Gitlab::ObjectifiedHash] The updated pipeline schedule variable
    def edit_pipeline_schedule_variable(project, id, key, value)
      put("/projects/#{url_encode project}/pipeline_schedules/#{id}/variables/#{key}", body: {value: value})
    end

    # Delete the variable of a pipeline schedule.
    #
    # @example
    #   Gitlab.delete_pipeline_schedule_variable(5, 13, key: 'NEW_VARIABLE')
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Integer] id The ID of a pipeline_schedule.
    # @param [String] key The key of the variable
    # @return [Gitlab::ObjectifiedHash]
    def delete_pipeline_schedule_variable(project, id, key)
      delete("/projects/#{url_encode project}/pipeline_schedules/#{id}/variables/#{key}")
    end
  end
end