import { useState } from 'react';
import type { DecisionTree, UserChoices, TreeNode } from '../../shared/types/decisions';
import decisionTreeData from '../../../../data/decision-tree.json';

// eslint-disable-next-line @typescript-eslint/no-explicit-any
const tree = decisionTreeData as any as DecisionTree;

interface ConfiguratorProps {
  onComplete: (choices: UserChoices) => void;
}

export function Configurator({ onComplete }: ConfiguratorProps) {
  const [currentNodeId, setCurrentNodeId] = useState('start');
  const [choices, setChoices] = useState<UserChoices>({});
  const [history, setHistory] = useState<string[]>([]);

  const currentNode: TreeNode | undefined = tree.nodes[currentNodeId];

  if (!currentNode) return <div>Erreur : noeud introuvable</div>;

  // Router node — auto-redirect based on condition
  if (currentNode.type === 'router' && currentNode.condition && currentNode.routes) {
    const value = choices[currentNode.condition] ?? '';
    const nextNode = currentNode.routes[value] ?? Object.values(currentNode.routes)[0];
    if (nextNode && nextNode !== currentNodeId) {
      // Use setTimeout to avoid state update during render
      setTimeout(() => setCurrentNodeId(nextNode), 0);
      return null;
    }
  }

  // Result node — finalize choices
  if (currentNode.type === 'result') {
    const finalChoices = { ...choices, ...currentNode.sets };
    return (
      <div className="mx-auto max-w-2xl space-y-6 p-8">
        <h2 className="text-2xl font-bold">Ton profil</h2>
        <div className="space-y-2 rounded-lg border border-border bg-card p-6">
          {Object.entries(finalChoices)
            .filter(([, v]) => v)
            .map(([key, value]) => (
              <div key={key} className="flex justify-between">
                <span className="text-muted">{key}</span>
                <span className="font-medium">{value}</span>
              </div>
            ))}
        </div>
        <button
          onClick={() => onComplete(finalChoices)}
          className="w-full rounded-lg bg-primary px-6 py-3 font-semibold text-primary-foreground transition-colors hover:bg-primary/90"
        >
          Voir mon guide personnalisé →
        </button>
      </div>
    );
  }

  // Choice node — display question + options
  const handleSelect = (option: { sets: Record<string, string>; next: string }) => {
    setChoices((prev) => ({ ...prev, ...option.sets }));
    setHistory((prev) => [...prev, currentNodeId]);
    setCurrentNodeId(option.next);
  };

  const handleBack = () => {
    const prev = history[history.length - 1];
    if (prev) {
      setHistory((h) => h.slice(0, -1));
      setCurrentNodeId(prev);
    }
  };

  return (
    <div className="mx-auto max-w-2xl space-y-6 p-8">
      {history.length > 0 && (
        <button onClick={handleBack} className="text-sm text-muted hover:text-foreground">
          ← Retour
        </button>
      )}

      <div className="space-y-2">
        <h2 className="text-2xl font-bold">{currentNode.question}</h2>
        {currentNode.source && (
          <p className="text-sm text-muted">Source : {currentNode.source}</p>
        )}
      </div>

      <div className="space-y-3">
        {currentNode.options?.map((option, i) => {
          const opt = option as unknown as Record<string, unknown>;
          const isDefault = !!opt.default_recommendation;
          return (
            <button
              key={i}
              onClick={() => handleSelect(option)}
              className={`w-full rounded-lg border p-4 text-left transition-colors hover:border-primary hover:bg-card/80 ${isDefault ? 'border-primary/40 bg-primary/5' : 'border-border bg-card'}`}
            >
              <div className="font-medium">
                {option.label}
                {isDefault && <span className="ml-2 text-xs text-primary">(recommandé EBSE)</span>}
              </div>
              {(opt.criteria as string) && (
                <div className="mt-1 text-sm text-muted">{opt.criteria as string}</div>
              )}
              {(opt.deduced_tech as string) && (
                <div className="mt-2 rounded bg-background px-3 py-1.5 text-xs text-muted-foreground">
                  💡 Le guide choisit : {opt.deduced_tech as string}
                </div>
              )}
              {isDefault && (
                <div className="mt-1 text-xs text-primary/80">
                  {opt.default_recommendation as string}
                </div>
              )}
            </button>
          );
        })}
      </div>

      <div className="text-xs text-muted">
        Étape {history.length + 1} · Chaque question sourcée EBSE · Rien d'inventé
      </div>
    </div>
  );
}
