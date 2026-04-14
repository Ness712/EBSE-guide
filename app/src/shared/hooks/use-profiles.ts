import { useState, useCallback } from 'react';
import type { Profile, UserChoices } from '../types/decisions';

const STORAGE_KEY = 'ebse-profiles';

function loadProfiles(): Profile[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    return raw ? (JSON.parse(raw) as Profile[]) : [];
  } catch {
    return [];
  }
}

function saveProfiles(profiles: Profile[]): void {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(profiles));
}

export function useProfiles() {
  const [profiles, setProfiles] = useState<Profile[]>(loadProfiles);

  const addProfile = useCallback(
    (name: string, choices: UserChoices) => {
      const profile: Profile = {
        name,
        created: new Date().toISOString(),
        choices,
      };
      const updated = [...profiles, profile];
      saveProfiles(updated);
      setProfiles(updated);
      return profile;
    },
    [profiles],
  );

  const deleteProfile = useCallback(
    (index: number) => {
      const updated = profiles.filter((_, i) => i !== index);
      saveProfiles(updated);
      setProfiles(updated);
    },
    [profiles],
  );

  const importProfile = useCallback(
    (json: string): Profile | null => {
      try {
        const data = JSON.parse(json) as { profile?: UserChoices; choices?: UserChoices; name?: string };
        const choices = data.profile ?? data.choices;
        if (!choices) return null;
        const profile: Profile = {
          name: data.name ?? `Import ${new Date().toLocaleDateString()}`,
          created: new Date().toISOString(),
          choices,
        };
        const updated = [...profiles, profile];
        saveProfiles(updated);
        setProfiles(updated);
        return profile;
      } catch {
        return null;
      }
    },
    [profiles],
  );

  const exportProfile = useCallback((profile: Profile) => {
    const blob = new Blob([JSON.stringify(profile, null, 2)], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `ebse-${profile.name.replace(/\s+/g, '-').toLowerCase()}.json`;
    a.click();
    URL.revokeObjectURL(url);
  }, []);

  return { profiles, addProfile, deleteProfile, importProfile, exportProfile };
}
