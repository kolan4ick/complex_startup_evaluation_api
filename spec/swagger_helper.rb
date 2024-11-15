# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s

  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: '{host}',
          variables: {
            host: {
              default: 'http://localhost:3001'
            }
          }
        }
      ],
      components: {
        securitySchemes: {
          bearerAuth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: 'JWT'
          }
        },
        schemas: {
          EffectivenessScore: {
            type: :object,
            properties: {
              id: { type: :integer, example: 1 },
              value: { type: :number, format: :float, example: 0.2 },
              order: { type: :integer, example: 1 },
              type: { type: :string, example: 'EffectivenessScores::Sum' }
            },
            required: %w[value order]
          },
          RiskScore: {
            type: :object,
            properties: {
              id: { type: :integer, example: 1 },
              authenticity: { type: :number, format: :float, example: 0.5 },
              linguistic: { type: :string, example: 'middle', enum: %w[low middle above_middle high below_middle] },
              order: { type: :integer, example: 1 },
              type: { type: :string, example: 'RiskScores::Financial' }
            },
            required: %w[authenticity linguistic order]
          },
          TeamScore: {
            type: :object,
            properties: {
              id: { type: :integer, example: 1 },
              confidence: { type: :number, format: :float, example: 0.8 },
              linguistic: { type: :string, example: 'high', enum: %w[low middle high below_middle above_middle] },
              order: { type: :integer, example: 1 },
              weight: { type: :integer, example: 8 },
              type: { type: :string, example: 'TeamScores::Stability' }
            },
            required: %w[confidence linguistic order weight]
          },
          Evaluation: {
            type: :object,
            properties: {
              id: { type: :integer, example: 1 },
              team_competencies: { type: :integer, example: 8 },
              team_competencies_and_experience: { type: :integer, example: 9 },
              team_leaders_competencies: { type: :integer, example: 10 },
              team_professional_activity: { type: :integer, example: 8 },
              team_stability: { type: :integer, example: 10 },
              feasibility_linguistic: { type: :string, example: 'high' },
              effectiveness_scores: {
                type: :array,
                items: { '$ref' => '#/components/schemas/EffectivenessScore' }
              },
              risk_scores: {
                type: :array,
                items: { '$ref' => '#/components/schemas/RiskScore' }
              },
              team_scores: {
                type: :array,
                items: { '$ref' => '#/components/schemas/TeamScore' }
              },
              created_at: { type: :string, format: :date_time },
              updated_at: { type: :string, format: :date_time }
            },
            required: %w[id team_competencies feasibility_linguistic]
          },
          EvaluationParams: {
            type: :object,
            properties: {
              evaluation: {
                type: :object,
                properties: {
                  team_competencies: { type: :integer, example: 8 },
                  team_competencies_and_experience: { type: :integer, example: 9 },
                  team_leaders_competencies: { type: :integer, example: 10 },
                  team_professional_activity: { type: :integer, example: 8 },
                  team_stability: { type: :integer, example: 10 },
                  feasibility_linguistic: { type: :string, example: 'high' },
                  effectiveness_sum_scores_attributes: {
                    type: :array,
                    items: { '$ref' => '#/components/schemas/EffectivenessScore' },
                    example: [
                      { value: 78.0, order: 1 },
                      { value: 45.0, order: 2 },
                      { value: 30.0, order: 3 },
                      { value: 186.0, order: 4 },
                      { value: 63.0, order: 5 }
                    ]
                  },
                  effectiveness_min_scores_attributes: {
                    type: :array,
                    items: { '$ref' => '#/components/schemas/EffectivenessScore' },
                    example: [
                      { value: 20.0, order: 1 },
                      { value: 15.0, order: 2 },
                      { value: 10.0, order: 3 },
                      { value: 50.0, order: 4 },
                      { value: 25.0, order: 5 }
                    ]
                  },
                  effectiveness_max_scores_attributes: {
                    type: :array,
                    items: { '$ref' => '#/components/schemas/EffectivenessScore' },
                    example: [
                      { value: 115.0, order: 1 },
                      { value: 60.0, order: 2 },
                      { value: 50.0, order: 3 },
                      { value: 225.0, order: 4 },
                      { value: 90.0, order: 5 }
                    ]
                  },
                  effectiveness_desired_scores_attributes: {
                    type: :array,
                    items: { '$ref' => '#/components/schemas/EffectivenessScore' },
                    example: [
                      { value: 80.0, order: 1 },
                      { value: 55.0, order: 2 },
                      { value: 35.0, order: 3 },
                      { value: 165.0, order: 4 },
                      { value: 50.0, order: 5 }
                    ]
                  },
                  effectiveness_weight_scores_attributes: {
                    type: :array,
                    items: { '$ref' => '#/components/schemas/EffectivenessScore' },
                    example: [
                      { value: 10, order: 1 },
                      { value: 8, order: 2 },
                      { value: 6, order: 3 },
                      { value: 7, order: 4 },
                      { value: 4, order: 5 }
                    ]
                  },
                  risk_financial_scores_attributes: {
                    type: :array,
                    items: { '$ref' => '#/components/schemas/RiskScore' },
                    example: [
                      { linguistic: 'middle', authenticity: 0.8, order: 1 },
                      { linguistic: 'low', authenticity: 0.9, order: 2 },
                      { linguistic: 'middle', authenticity: 0.1, order: 3 },
                      { linguistic: 'above_middle', authenticity: 0.7, order: 4 },
                      { linguistic: 'middle', authenticity: 0.6, order: 5 }
                    ]
                  },
                  risk_investment_scores_attributes: {
                    type: :array,
                    items: { '$ref' => '#/components/schemas/RiskScore' },
                    example: [
                      { linguistic: 'low', authenticity: 0.2, order: 1 },
                      { linguistic: 'low', authenticity: 0.8, order: 2 },
                      { linguistic: 'above_middle', authenticity: 0.4, order: 3 },
                      { linguistic: 'low', authenticity: 0.6, order: 4 },
                      { linguistic: 'above_middle', authenticity: 0.7, order: 5 }
                    ]
                  },
                  risk_operational_scores_attributes: {
                    type: :array,
                    items: { '$ref' => '#/components/schemas/RiskScore' },
                    example: [
                      { linguistic: 'below_middle', authenticity: 0.8, order: 1 },
                      { linguistic: 'below_middle', authenticity: 0.7, order: 2 },
                      { linguistic: 'below_middle', authenticity: 0.4, order: 3 },
                      { linguistic: 'below_middle', authenticity: 0.3, order: 4 },
                      { linguistic: 'below_middle', authenticity: 0.9, order: 5 },
                      { linguistic: 'below_middle', authenticity: 0.4, order: 6 },
                      { linguistic: 'middle', authenticity: 0.6, order: 7 },
                      { linguistic: 'above_middle', authenticity: 0.8, order: 8 },
                      { linguistic: 'middle', authenticity: 0.1, order: 9 }
                    ]
                  },
                  risk_innovation_activity_scores_attributes: {
                    type: :array,
                    items: { '$ref' => '#/components/schemas/RiskScore' },
                    example: [
                      { linguistic: 'low', authenticity: 0.8, order: 1 },
                      { linguistic: 'low', authenticity: 0.9, order: 2 },
                      { linguistic: 'below_middle', authenticity: 0.1, order: 3 },
                      { linguistic: 'below_middle', authenticity: 0.7, order: 4 },
                      { linguistic: 'below_middle', authenticity: 0.6, order: 5 }
                    ]
                  },
                  team_stability_scores_attributes: {
                    type: :array,
                    items: { '$ref' => '#/components/schemas/TeamScore' },
                    example: [
                      { linguistic: 'high', confidence: 0.8, weight: 8, order: 1 },
                      { linguistic: 'below_middle', confidence: 0.9, weight: 9, order: 2 }
                    ]
                  },
                  team_professional_competency_scores_attributes: {
                    type: :array,
                    items: { '$ref' => '#/components/schemas/TeamScore' },
                    example: [
                      { linguistic: 'high', confidence: 0.7, weight: 8, order: 1 },
                      { linguistic: 'high', confidence: 0.8, weight: 10, order: 2 },
                      { linguistic: 'middle', confidence: 0.6, weight: 9, order: 3 },
                      { linguistic: 'middle', confidence: 0.5, weight: 10, order: 4 },
                      { linguistic: 'middle', confidence: 0.7, weight: 7, order: 5 }
                    ]
                  },
                  team_professional_activity_scores_attributes: {
                    type: :array,
                    items: { '$ref' => '#/components/schemas/TeamScore' },
                    example: [
                      { linguistic: 'below_middle', confidence: 0.8, weight: 8, order: 1 },
                      { linguistic: 'high', confidence: 0.9, weight: 6, order: 2 },
                      { linguistic: 'middle', confidence: 0.9, weight: 7, order: 3 },
                      { linguistic: 'below_middle', confidence: 0.8, weight: 9, order: 4 }
                    ]
                  }
                },
                required: %w[team_competencies feasibility_linguistic]
              }
            }
          }
        }
      },
      security: [
        { bearerAuth: [] }
      ]
    }
  }

  config.openapi_format = :yaml
end
