import { createContext, useContext } from "react";
import useLocalStorage from "../hooks/useLocalStorage";
import { useEffect } from "react";
import { useCallback } from "react";

const ThemeContext = createContext();

// custom consumer hook
export const useTheme = () => {
  const context = useContext(ThemeContext);
  if (!context) throw new Error("useTheme must be used within ThemeProvider");
  return context;
};

export function ThemeProvider({ children }) {
  const [dark, setDark] = useLocalStorage("rm_dark", false);

  useEffect(() => {
    if (dark) {
      document.documentElement.classList.add("dark");
    } else {
      document.documentElement.classList.remove("dark");
    }
  }, [dark]);

  const toggle = useCallback(() => setDark((d) => !d), [setDark]);

  return (
    <ThemeContext.Provider value={{ dark, toggle }}>
      {children}
    </ThemeContext.Provider>
  );
}
