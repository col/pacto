module Pacto
  module Validators
    class ResponseBodyValidator < BodyValidator
      def initialize(app)
        @app = app
      end

      def self.section_name
        'response'
      end

      def call(env)
        if env[:validation_results].empty? # skip body validation if we already have other errors
          expected_body = env[:contract].response.schema
          actual_body = env[:actual_response]
          errors = self.class.validate(expected_body, actual_body)
          env[:validation_results].concat errors.compact
        end
        @app.call env
      end
    end
  end
end