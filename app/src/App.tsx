import { useState } from 'react';
import type { UserChoices } from './shared/types/decisions';
import { Configurator } from './features/configurator/configurator';
import { ProfileManager } from './features/configurator/profile-manager';
import { GuideView } from './features/guide/guide-view';
import { useProfiles } from './shared/hooks/use-profiles';
import { useAllDecisions, useFilteredDecisions } from './shared/hooks/use-decisions';
import { generateApiResponse } from './features/export/api-export';

type AppState = 'home' | 'configurator' | 'guide';

export default function App() {
  const [state, setState] = useState<AppState>('home');
  const [choices, setChoices] = useState<UserChoices>({});
  const { addProfile } = useProfiles();
  const allDecisions = useAllDecisions();
  const filtered = useFilteredDecisions(allDecisions, choices);

  const handleComplete = (newChoices: UserChoices) => {
    setChoices(newChoices);
    setState('guide');
  };

  const handleReset = () => {
    setChoices({});
    setState('home');
  };

  const handleExport = () => {
    const apiResponse = generateApiResponse(choices, filtered);
    const blob = new Blob([JSON.stringify(apiResponse, null, 2)], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `ebse-guide-${choices.backend ?? 'custom'}-${Date.now()}.json`;
    a.click();
    URL.revokeObjectURL(url);
  };

  const handleSaveProfile = () => {
    const name = prompt('Nom du profil :');
    if (name) addProfile(name, choices);
  };

  return (
    <div className="min-h-screen">
      <header className="border-b border-border p-4">
        <div className="mx-auto flex max-w-4xl items-center justify-between">
          <button onClick={handleReset} className="text-lg font-bold hover:opacity-80">
            EBSE Guide{' '}
            <span className="text-sm font-normal text-muted">Evidence-Based</span>
          </button>
          <div className="flex gap-3">
            {state === 'guide' && (
              <>
                <button
                  onClick={handleSaveProfile}
                  className="text-sm text-muted hover:text-foreground"
                >
                  💾 Sauvegarder
                </button>
                <button
                  onClick={handleExport}
                  className="text-sm text-muted hover:text-foreground"
                >
                  📤 Exporter JSON
                </button>
              </>
            )}
          </div>
        </div>
      </header>

      <main>
        {state === 'home' && (
          <div className="space-y-8">
            <div className="mx-auto max-w-2xl space-y-4 p-8 text-center">
              <h1 className="text-4xl font-bold">EBSE Guide</h1>
              <p className="text-lg text-muted">
                Le guide de décisions techniques basé sur l'evidence. Rien d'inventé, tout sourcé.
              </p>
              <button
                onClick={() => setState('configurator')}
                className="rounded-lg bg-primary px-8 py-3 font-semibold text-primary-foreground transition-colors hover:bg-primary/90"
              >
                Configurer mon projet →
              </button>
            </div>
            <ProfileManager onLoadProfile={handleComplete} />
          </div>
        )}
        {state === 'configurator' && <Configurator onComplete={handleComplete} />}
        {state === 'guide' && (
          <GuideView choices={choices} onReset={handleReset} onExport={handleExport} />
        )}
      </main>
    </div>
  );
}
