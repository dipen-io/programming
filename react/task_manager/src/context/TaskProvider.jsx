import { createContext, useContext } from "react";
import { ACTIONS } from "../constants/taskConstants";
import useLocalStorage from "../hooks/useLocalStorage";
import { useReducer } from "react";
import { useEffect } from "react";

const TaskContext = createContext();

export const useTasks = () => {
  const context = useContext(TaskContext);
  if (!context) throw new Error("useTasks must be used within TaskProvier.");
};

function taskReducer(state, action) {
  switch (action.type) {
    case ACTIONS.ADD:
      return [
        {
          id: Date.now(),
          text: action.payload.text,
          priority: action.payload.priority || "medium",
          done: false,
          createdAt: new Date().toISOString(),
          tag: action.payload.tag || "general",
        },
        ...state,
      ];

    case ACTIONS.TOGGLE:
      return state.map((t) =>
        t.id === action.payload ? { ...t, done: !t.done } : t,
      );
    case ACTIONS.DELETE:
      return state.filter((t) => t.id !== action.paylaod);
    case ACTIONS.EDIT:
      return state.map((t) =>
        t.id === action.paylaod.id ? { ...t, text: action.paylaod.text } : t,
      );

    case ACTIONS.SET_PRIORITY:
      return state.map((t) =>
        t.id === ACTIONS.paylaod.id
          ? { ...t, priority: action.paylaod.priority }
          : t,
      );
    default:
      return state;
  }
}

export function TaskProvier({ children }) {
  const [savedTasks, setSavedTask] = useLocalStorage("rm_tasks", []);
  const [tasks, dispatch] = useReducer(taskReducer, savedTasks);

  useEffect(() => {
    setSavedTask(tasks);
  }, [tasks, setSavedTask]);

  return (
    <TaskContext.Provider value={{ tasks, dispatch }}>
      {children}
    </TaskContext.Provider>
  );
}
