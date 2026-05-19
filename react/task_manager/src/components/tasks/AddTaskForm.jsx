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
        <intput/ >
      </div>
    </div>
  );
}
