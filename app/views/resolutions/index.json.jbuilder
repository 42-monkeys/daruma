# frozen_string_literal: true

json.array! @resolutions, partial: 'resolutions/resolution', as: :resolution
