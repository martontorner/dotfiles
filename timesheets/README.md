# TimesheetS

To setup create the following config file:

- replace `[workspace]` value with your Toggl Track workspace ID
- replace `[token]` values with your actual API tokens

```yaml
# ~/.config/timesheets/config.yaml
# OR
# ~/Library/Application Support/timesheets/config.yaml
source:
  kind: TogglTrack
  spec:
    workspace: [workspace]
    token: [token]

target:
  kind: CapsysKronos
  spec:
    token: [token]
    tags:
      home-office: { siteId: 34 }
      development: { activityTypeId: 5 }
      meeting: { activityTypeId: 12 }
      presentation: { activityTypeId: 14 }
      research: { activityTypeId: 24 }
      review: { activityTypeId: 19 }
      documentation: { activityTypeId: 1 }
      system-maintenance: { activityTypeId: 30 }
      design: { activityTypeId: 25 }
      planning: { activityTypeId: 25 }
      training: { activityTypeId: 15 }
      specification: { activityTypeId: 20 }

timezone: Europe/Budapest
```

TODO: should separate auth (auth.json) from config (config.yaml) and create linked config.
