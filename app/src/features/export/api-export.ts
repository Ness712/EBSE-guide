import type { UserChoices } from '../../shared/types/decisions';
import type { FilteredRecommendation } from '../../shared/hooks/use-decisions';

export interface ApiResponse {
  stack: Record<string, string>;
  recommendations: ApiRecommendation[];
  total: number;
  methodology: string;
  exported_at: string;
}

export interface ApiRecommendation {
  id: string;
  domain: string;
  question: string;
  recommendation: string;
  grade: number;
  level: string;
  implementation?: string;
  is_universal: boolean;
  sources: Array<{ name: string; pyramid: number; year: number }>;
}

export function generateApiResponse(
  choices: UserChoices,
  filtered: FilteredRecommendation[],
): ApiResponse {
  const backend = choices.backend ?? 'unknown';

  return {
    stack: {
      backend: choices.backend ?? 'not set',
      frontend: choices.frontend ?? 'not set',
      database: choices.database ?? 'not set',
      approach: choices.approach ?? 'not set',
    },
    recommendations: filtered.map((rec) => {
      const decision = rec.decision;
      const variant = decision.variants?.[backend];
      const sources = variant?.sources ?? decision.universal?.principles?.[0]?.sources ?? [];

      return {
        id: decision.id,
        domain: decision.domain,
        question: decision.question,
        recommendation: rec.recommendation,
        grade: rec.grade,
        level: rec.level,
        implementation: rec.implementation,
        is_universal: rec.isUniversal,
        sources: sources.map((s: { name: string; pyramid: number; year: number }) => ({
          name: s.name,
          pyramid: s.pyramid,
          year: s.year,
        })),
      };
    }),
    total: filtered.length,
    methodology: 'EBSE (Kitchenham 2004), adapted from Evidence-Based Medicine',
    exported_at: new Date().toISOString(),
  };
}
