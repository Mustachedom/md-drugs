import { onDestroy } from "svelte";

interface NuiMessage<T = unknown> {
  action: string;
  data: T;
}

type NuiEventHandler<T = any> = (data: T) => void;

const eventListeners = new Map<string, NuiEventHandler[]>();

const eventListener = (event: MessageEvent<NuiMessage>) => {
  const { action, data } = event.data;
  const handlers = eventListeners.get(action);

  if (handlers) {
    handlers.forEach((handler) => handler(data));
  }
};

window.addEventListener("message", eventListener);

/**
 * A function that manage events listeners for receiving data from the client scripts
 * @param action The specific `action` that should be listened for.
 * @param handler The callback function that will handle data relayed by this function
 *
 * @example
 * useNuiEvent<{visibility: true, wasVisible: 'something'}>('setVisible', (data) => {
 *   // whatever logic you want
 * })
 *
 **/
export function useNuiEvent<T = unknown>(
  action: string,
  handler: NuiEventHandler<T>
) {
  const handlers = eventListeners.get(action) || [];
  handlers.push(handler);
  eventListeners.set(action, handlers);

  onDestroy(() => {
    const handlers = eventListeners.get(action) || [];

    eventListeners.set(
      action,
      handlers.filter((h) => h !== handler)
    );
  });
}
