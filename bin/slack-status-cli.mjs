#!/usr/bin/env node

const SLACK_TOKEN = process.env.SLACK_STATUS_CLI_TOKEN;

if (!SLACK_TOKEN) {
  console.error('❌ Missing SLACK_TOKEN in env');
  process.exit(1);
}

const [, , ...args] = process.argv;
let payload;
if (args[0] === 'clear') {
  payload = {
    profile: {
      status_text: '',
      status_emoji: '',
    },
  };
} else {
  const [emoji, ...statusWords] = args;

  if (!emoji || statusWords.length === 0) {
    console.error('Usage: ./cli.mjs <emoji> <status text> | clear');
    process.exit(1);
  }

  payload = {
    profile: {
      status_text: statusWords.join(' '),
      status_emoji: emoji,
    },
  };
}

const resp = await fetch('https://slack.com/api/users.profile.set', {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${SLACK_TOKEN}`,
    'Content-Type': 'application/json',
  },
  body: JSON.stringify(payload),
});

const json = await resp.json();
process.exit(json.ok ? 0 : 1);
