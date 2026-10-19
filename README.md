# Homebrew tap

```sh
brew install gregrmunday/tap/fomo
brew services start fomo
```

| Formula | What it is |
| --- | --- |
| [`fomo`](https://github.com/gregrmunday/fomo) | Cornwall's wave buoys and forecast in the macOS menu bar |

Fomo is built from source on your Mac, so it needs no Apple signing and shows no "unidentified developer" warning. The first install also installs Homebrew's Rust to build it; run `brew autoremove` afterwards to remove that again.

## Releasing a new Fomo version

1. Tag the release in [gregrmunday/fomo](https://github.com/gregrmunday/fomo) (for example `v0.3.0`) and publish it.
2. Open a pull request here that updates `url` and `sha256` in `Formula/fomo.rb`:

   ```sh
   brew bump-formula-pr --url=https://github.com/gregrmunday/fomo/archive/refs/tags/v0.3.0.tar.gz gregrmunday/tap/fomo
   ```

3. **brew test-bot** builds and tests bottles on macOS 15 for Apple Silicon and Intel.
4. When it passes, run **brew pr-pull** from the Actions tab (or `gh workflow run publish.yml -f pull_request=<number>`). It uploads the bottles to a release here and commits them to the formula on `main`.

Friends then get the update with `brew upgrade fomo && brew services restart fomo`.
