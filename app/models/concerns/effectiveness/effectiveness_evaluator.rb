# frozen_string_literal: true

class EffectivenessEvaluator
  attr_accessor :sum_scores, :min_scores, :max_scores, :desired_scores, :desired_terms, :weight_scores

  def initialize(**scores)
    @sum_scores = scores[:sum_scores]
    @min_scores = scores[:min_scores]
    @max_scores = scores[:max_scores]
    @desired_scores = scores[:desired_scores]
    @desired_terms = scores[:desired_terms]
    @weight_scores = normalize(scores[:weight_scores])
  end

  # Evaluate the effectiveness of the startup
  def evaluate
    # First level
    membership_actual = membership(@sum_scores, @min_scores, @max_scores)

    membership_desired = membership(@desired_scores, @min_scores, @max_scores)

    # Second level
    membership_u = membership_u(membership_actual, membership_desired)

    # Third level
    max_membership = max_membership(membership_u, @desired_terms)

    # Final level
    aggregated_score = aggregated_valuating(max_membership, @weight_scores)

    linguistic = linguistic_valuating(aggregated_score)

    { membership_actual:, membership_desired:, membership_u:, max_membership:, aggregated_score:, linguistic: }
  end

  private

  def membership(arr, min_scores, max_scores)
    arr.each_with_index.map do |value, i|
      calculate_membership(value, min_scores[i], max_scores[i])
    end
  end

  def calculate_membership(value, min_score, max_score)
    return 0 if value <= min_score

    midpoint = (min_score + max_score) / 2.0

    if value <= midpoint
      2 * (((value - min_score) / (max_score - min_score))**2)
    elsif value < max_score
      1 - 2 * ((max_score - value) / (max_score - min_score))**2
    else
      1
    end
  end

  def membership_u(membership_actual, membership_desired)
    membership_actual.map.with_index do |actual, i|
      [
        membership_u1(actual, membership_desired[i]),
        membership_u2(actual, membership_desired[i]),
        membership_u3(actual, membership_desired[i]),
        membership_u4(actual, membership_desired[i]),
        membership_u5(actual, membership_desired[i])
      ].reduce(&:merge).compact
    end
  end

  def max_membership(membership_u, desired_terms)
    res = []

    membership_u.each_with_index do |v, i|
      a = v[desired_terms[i]] || 0
      b = (v[desired_terms[i] + 1] || v[desired_terms[i] - 1] || 0) / 2
      res << [a, b].max
    end

    res
  end

  def normalize(arr)
    arr.map do |i|
      i / arr.sum
    end
  end

  def aggregated_valuating(max_membership, weights)
    max_membership.map.with_index { |v, i| v * weights[i] }.sum
  end

  def linguistic_valuating(aggregated_score)
    case aggregated_score
    when 0..0.21 then 'оцінка ідеї дуже низька'
    when 0.21..0.36 then 'оцінка ідеї низька'
    when 0.36..0.47 then 'оцінка ідеї середня'
    when 0.47..0.67 then 'оцінка ідеї висока'
    when 0.67..1 then 'оцінка ідеї дуже висока'
    else 'оцінка ідеї невизначена'
    end
  end

  def membership_u1(actual, desired)
    { 1 => if actual <= desired - (desired / 2)
             1
           elsif desired - (desired / 2) < actual && actual <= desired - (desired / 4)
             (3 * desired - 4 * actual) / desired
           end }
  end

  def membership_u2(actual, desired)
    { 2 => if desired - (desired / 2) < actual && actual <= desired - (desired / 4)
             (4 * actual - 2 * desired) / desired
           elsif desired - (desired / 4) < actual && actual <= desired
             (4 * desired - 4 * actual) / desired
           end }
  end

  def membership_u3(actual, desired)
    { 3 => if desired - (desired / 4) < actual && actual <= desired
             (4 * actual - 3 * desired) / desired
           elsif desired < actual && actual <= desired + (desired / 4)
             (5 * desired - 4 * actual) / desired
           end }
  end

  def membership_u4(actual, desired)
    { 4 => if desired < actual && actual <= desired + (desired / 4)
             (4 * actual - 4 * desired) / desired
           elsif desired + (desired / 4) < actual && actual <= desired + (desired / 2)
             (6 * desired - 4 * actual) / desired
           end }
  end

  def membership_u5(actual, desired)
    { 5 => if desired + (desired / 4) < actual && actual <= desired + (desired / 2)
             (4 * actual - 5 * desired) / desired
           elsif actual >= desired + (desired / 2)
             1
           end }
  end
end
