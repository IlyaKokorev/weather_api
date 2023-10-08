# frozen_string_literal: true

module Callable
  def call(**args)
    new(**args).call
  end
end
