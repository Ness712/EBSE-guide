import { useRef } from 'react';
import type { Profile, UserChoices } from '../../shared/types/decisions';
import { useProfiles } from '../../shared/hooks/use-profiles';

// Pre-built profiles
const prebuiltProfiles: Profile[] = [
  {
    name: 'Optimal (EBSE)',
    created: '2026-04-14',
    choices: {
      approach: 'optimal',
      project_type: 'spa',
      scale: 'startup',
      backend: 'typescript-nestjs',
      frontend: 'react',
      database: 'postgresql',
      budget: 'open-source',
    },
  },
  {
    name: 'Java / Spring Boot + React',
    created: '2026-04-14',
    choices: {
      approach: 'constrained',
      backend: 'java-spring-boot',
      frontend: 'react',
      database: 'postgresql',
      budget: 'open-source',
    },
  },
  {
    name: 'Python / Django + React',
    created: '2026-04-14',
    choices: {
      approach: 'constrained',
      backend: 'python-django',
      frontend: 'react',
      database: 'postgresql',
      budget: 'open-source',
    },
  },
  {
    name: 'TypeScript / NestJS + React',
    created: '2026-04-14',
    choices: {
      approach: 'constrained',
      backend: 'typescript-nestjs',
      frontend: 'react',
      database: 'postgresql',
      budget: 'open-source',
    },
  },
];

interface ProfileManagerProps {
  onLoadProfile: (choices: UserChoices) => void;
}

export function ProfileManager({ onLoadProfile }: ProfileManagerProps) {
  const { profiles, deleteProfile, importProfile, exportProfile } = useProfiles();
  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleImport = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = () => {
      const result = importProfile(reader.result as string);
      if (result) onLoadProfile(result.choices);
    };
    reader.readAsText(file);
  };

  return (
    <div className="mx-auto max-w-2xl space-y-6 p-8">
      <h2 className="text-2xl font-bold">Profils pré-configurés</h2>
      <p className="text-sm text-muted">Charge un profil pour accéder directement au guide.</p>

      <div className="space-y-3">
        {prebuiltProfiles.map((p) => (
          <button
            key={p.name}
            onClick={() => onLoadProfile(p.choices)}
            className="w-full rounded-lg border border-border bg-card p-4 text-left transition-colors hover:border-primary"
          >
            <div className="font-medium">{p.name}</div>
            <div className="mt-1 text-sm text-muted">
              {p.choices.backend?.replace(/-/g, ' ')} · {p.choices.frontend} · {p.choices.database}
            </div>
          </button>
        ))}
      </div>

      {profiles.length > 0 && (
        <>
          <h3 className="text-lg font-semibold">Tes profils sauvegardés</h3>
          <div className="space-y-2">
            {profiles.map((p, i) => (
              <div
                key={i}
                className="flex items-center justify-between rounded-lg border border-border bg-card p-3"
              >
                <button
                  onClick={() => onLoadProfile(p.choices)}
                  className="flex-1 text-left"
                >
                  <div className="font-medium">{p.name}</div>
                  <div className="text-xs text-muted">{new Date(p.created).toLocaleDateString()}</div>
                </button>
                <div className="flex gap-2">
                  <button
                    onClick={() => exportProfile(p)}
                    className="text-xs text-muted hover:text-foreground"
                  >
                    Exporter
                  </button>
                  <button
                    onClick={() => deleteProfile(i)}
                    className="text-xs text-error hover:text-error/80"
                  >
                    Supprimer
                  </button>
                </div>
              </div>
            ))}
          </div>
        </>
      )}

      <div className="border-t border-border pt-4">
        <input
          ref={fileInputRef}
          type="file"
          accept=".json"
          onChange={handleImport}
          className="hidden"
        />
        <button
          onClick={() => fileInputRef.current?.click()}
          className="text-sm text-muted hover:text-foreground"
        >
          📂 Importer un profil JSON
        </button>
      </div>
    </div>
  );
}
