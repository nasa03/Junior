import { saveAndSendPrompt } from './saveAndSendPrompt.js';
import processPrompt from '../prompt/processPrompt.js';
import { loadPromptDescriptor } from '../prompt/loadPromptDescriptor.js';
import watchPromptDescriptor from '../prompt/watchPromptDescriptor.js';
import { rl } from '../config.js';

const startInteractiveSession = async () => {
  await loadPromptDescriptor(console.log);
watchPromptDescriptor(console.log);
  rl.question('Notes: ', async (task) => {
    let { prompt } = await processPrompt(task);
    console.log("Your prompt: ", prompt);
    rl.question('Do you want to send this prompt? (y/n): ', async (confirmation) => {
      if (confirmation.toLowerCase() === 'y') {
        await saveAndSendPrompt(prompt, task);
      } else {
        startInteractiveSession();
      }
    });
  });
};

export { startInteractiveSession };

