import { useState } from "react";
import { useTasks } from "../../context/TaskProvider";
import { useRef } from "react";

export default function AddTaskForm() {
  const { dispatch } = useTasks();
  const [text, setText] = useState("");
  const [priority, setPriority] = useState("medium");
  const [tag, setTag] = useState("general");
  const inputRef = useRef(null);

  const handleAdd = () => {};

  return (
    <div className="bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-2xl  p-4 mb-6 shadow-sm">
      <div className="flex gap-2 flex-wrap sm:flex-nowrap">
        <input
          type="text"
          ref={inputRef}
          value={text}
          onChange={(e) => setText(e.target.value)}
          onKeyDown={(e) => e.key === "Enter" && handleAdd()}
          placeholder="That's need to be done?"
          className="flex-1 p-2.5 rounded-lg border border-slate-200 dark:border-slate-600 bg-slate-50 dark:bg-slate-900 outline-none focus:ring-2 focus:ring-indigo-500 min-w-0"
        />
        <select
          value={priority}
          onChange={(e) => setPriority(e.target.value)}
          className="p-2.5 rounded-lg border border-slate-200 dark:border-slate-600 bg-slate-50 dark:bg-slate-900 cursor-pointer outline-none focus:ring-2 focus:ring-indigo-500"
        >
          {["general", "work", "personal", "study", "health"].map((e) => (
            <option key={e} value={e}>
              {" "}
              {e}
            </option>
          ))}
        </select>
      </div>
      <button
        className="w-full mt-3 py-2.5 bg-indigo-500 text-white font-bold rounded-lg hover:bg-indigo-600 transition-colors opacity-50"
        onClick={handleAdd}
        disabled={!text.trim()}
      >
        {" "}
        + Add Task
      </button>
    </div>
  );
}
