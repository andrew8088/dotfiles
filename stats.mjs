#!/usr/bin/env zx

$.verbose = false;

try {
  await $`git rev-parse --git-dir`;
} catch (err) {
  if (err.stderr.includes('not a git repository')) {
    throw chalk.red('Run this script in a git repo');
  } else {
    throw err;
  }
}

const { stdout: log } = await $`git log --name-only`;

const commits = log.split('\ncommit').map(c => {
  const [hash, author, date, _1, message, _2, ...files] = c.trim().split('\n');

  return {
    hash: hash.trim(),
    author: author.split('Author: ')[1].split('<')[0].trim(),
    date: new Date(date.split('Date:')[1].trim()),
    message: message.trim(),
    files
  };
});

const x = await $`echo ${commits.map(c => c.files.join('\n')).join('\n')} | sort | uniq -c | sort -n | tail -10`
console.log(x.stdout);

const files = {};

for (const c of commits) {
  for (const f of c.files) {
    if (!files[f]) {
      files[f] = 0;
    }
    files[f]++;
  }
}

console.log(Object.entries(files).sort((a, b) => b[1] - a[1]).slice(0, 10));
