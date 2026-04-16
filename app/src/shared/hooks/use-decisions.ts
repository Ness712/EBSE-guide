import { useMemo } from 'react';
import type { Decision, UserChoices, StackVariant } from '../types/decisions';

const decisionModules = import.meta.glob<{ default: Decision }>(
  '../../../guide/data/decisions/*.json',
  { eager: true },
);

export function useAllDecisions(): Decision[] {
  return useMemo(() => {
    return Object.values(decisionModules).map((mod) => mod.default);
  }, []);
}

export interface FilteredRecommendation {
  decision: Decision;
  recommendation: string;
  grade: number;
  level: string;
  implementation?: string;
  code?: string;
  isUniversal: boolean;
}

export function useFilteredDecisions(
  decisions: Decision[],
  choices: UserChoices,
): FilteredRecommendation[] {
  return useMemo(() => {
    const backend = choices.backend ?? 'java-spring-boot';

    return decisions.map((d) => {
      // Universal decisions — show the first principle
      if (d.classification === 'universal' || !d.variants || Object.keys(d.variants).length === 0) {
        const principle = d.universal?.principles?.[0];
        return {
          decision: d,
          recommendation: principle?.text ?? d.question,
          grade: principle?.grade ?? 0,
          level: principle?.level ?? 'CHOIX_EQUIPE',
          isUniversal: true,
        };
      }

      // Stack-specific or mixed — find the variant matching user's backend choice
      const variant: StackVariant | undefined =
        d.variants[backend] ?? Object.values(d.variants)[0];

      if (variant) {
        return {
          decision: d,
          recommendation: variant.recommendation,
          grade: variant.grade,
          level: variant.level,
          implementation: variant.implementation,
          code: variant.code,
          isUniversal: false,
        };
      }

      // Fallback to universal principle
      const principle = d.universal?.principles?.[0];
      return {
        decision: d,
        recommendation: principle?.text ?? d.question,
        grade: principle?.grade ?? 0,
        level: principle?.level ?? 'CHOIX_EQUIPE',
        isUniversal: true,
      };
    }).sort((a, b) => b.grade - a.grade);
  }, [decisions, choices]);
}
