/** Returns a boolean value if the resource is shown in a browser window */
export const isEnvBrowser = (): boolean => !(window as any).invokeNative;
