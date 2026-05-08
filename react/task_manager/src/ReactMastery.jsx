// ============================================================
// REACT MASTERY PROJECT — Task Manager
// Concepts covered (annotated inline):
//  1. useState           — local state
//  2. useEffect          — side effects & cleanup
//  3. useRef             — DOM refs & mutable values
//  4. useReducer         — complex state logic
//  5. useContext         — global state / theme
//  6. useMemo            — derived / memoized values
//  7. useCallback        — stable function references
//  8. Custom hook        — useLocalStorage
//  9. Context API        — ThemeContext, TaskContext
// 10. React.memo         — prevent unnecessary re-renders
// 11. createPortal       — modal rendered outside root
// 12. Controlled inputs  — form state management
// 13. Lifting state      — child → parent communication
// 14. Composition        — slot-pattern with children prop
// 15. Keys & lists       — correct reconciliation
// ============================================================

import {
  useState, useEffect, useRef, useReducer,
  useContext, useMemo, useCallback, createContext, memo
} from "react";
import { createPortal } from "react-dom";

// ─────────────────────────────────────────────
// CONCEPT 8 — Custom Hook: useLocalStorage
// Encapsulates localStorage sync with useState
// ─────────────────────────────────────────────
function useLocalStorage(key, initial) {
  const [value, setValue] = useState(() => {
    try {
      const stored = localStorage.getItem(key);
      return stored ? JSON.parse(stored) : initial;
    } catch {
      return initial;
    }
  });

  useEffect(() => {
    // CONCEPT 2 — useEffect: sync state → localStorage
    localStorage.setItem(key, JSON.stringify(value));
  }, [key, value]);

  return [value, setValue];
}

// ─────────────────────────────────────────────
// CONCEPT 9 — Context API
// Two separate contexts: theme & tasks
// ─────────────────────────────────────────────
const ThemeContext = createContext();
const TaskContext = createContext();

// ─────────────────────────────────────────────
// CONCEPT 4 — useReducer: task state machine
// All task mutations flow through this reducer
// ─────────────────────────────────────────────
const ACTIONS = {
  ADD: "ADD",
  TOGGLE: "TOGGLE",
  DELETE: "DELETE",
  EDIT: "EDIT",
  SET_PRIORITY: "SET_PRIORITY",
  REORDER: "REORDER",
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
        t.id === action.payload ? { ...t, done: !t.done } : t
      );
    case ACTIONS.DELETE:
      return state.filter((t) => t.id !== action.payload);
    case ACTIONS.EDIT:
      return state.map((t) =>
        t.id === action.payload.id ? { ...t, text: action.payload.text } : t
      );
    case ACTIONS.SET_PRIORITY:
      return state.map((t) =>
        t.id === action.payload.id
          ? { ...t, priority: action.payload.priority }
          : t
      );
    default:
      return state;
  }
}

// ─────────────────────────────────────────────
// PROVIDERS — wrap the app with both contexts
// ─────────────────────────────────────────────
function ThemeProvider({ children }) {
  const [dark, setDark] = useLocalStorage("rm_dark", false);
  // CONCEPT 7 — useCallback: stable toggle reference
  const toggle = useCallback(() => setDark((d) => !d), [setDark]);
  return (
    <ThemeContext.Provider value={{ dark, toggle }}>
      {children}
    </ThemeContext.Provider>
  );
}

function TaskProvider({ children }) {
  const [savedTasks, setSavedTasks] = useLocalStorage("rm_tasks", []);
  const [tasks, dispatch] = useReducer(taskReducer, savedTasks);

  // CONCEPT 2 — useEffect: keep localStorage in sync with reducer
  useEffect(() => {
    setSavedTasks(tasks);
  }, [tasks]);

  return (
    <TaskContext.Provider value={{ tasks, dispatch }}>
      {children}
    </TaskContext.Provider>
  );
}

// ─────────────────────────────────────────────
// CONCEPT 11 — createPortal: Modal
// Renders outside #root into document.body
// ─────────────────────────────────────────────
function Modal({ task, onClose, onSave }) {
  const { dark } = useContext(ThemeContext);
  // CONCEPT 1 — useState: controlled edit input
  const [text, setText] = useState(task.text);
  // CONCEPT 3 — useRef: auto-focus the input
  const inputRef = useRef(null);

  // CONCEPT 2 — useEffect: focus on mount, ESC to close
  useEffect(() => {
    inputRef.current?.focus();
    const handler = (e) => e.key === "Escape" && onClose();
    window.addEventListener("keydown", handler);
    return () => window.removeEventListener("keydown", handler); // cleanup!
  }, [onClose]);

  const content = (
    <div style={styles.overlay} onClick={onClose}>
      <div
        style={{ ...styles.modal, ...(dark ? styles.modalDark : {}) }}
        onClick={(e) => e.stopPropagation()} // prevent bubble
      >
        <h3 style={styles.modalTitle}>Edit Task</h3>
        {/* CONCEPT 12 — Controlled input */}
        <input
          ref={inputRef}
          value={text}
          onChange={(e) => setText(e.target.value)}
          style={{ ...styles.input, ...(dark ? styles.inputDark : {}) }}
          onKeyDown={(e) => e.key === "Enter" && onSave(text)}
        />
        <div style={styles.modalActions}>
          <button style={styles.btnSecondary} onClick={onClose}>
            Cancel
          </button>
          <button
            style={styles.btnPrimary}
            onClick={() => onSave(text)}
            disabled={!text.trim()}
          >
            Save
          </button>
        </div>
      </div>
    </div>
  );

  // Portal renders into body, outside the React root
  return createPortal(content, document.body);
}

// ─────────────────────────────────────────────
// CONCEPT 10 — React.memo: TaskCard
// Only re-renders when its own props change
// ─────────────────────────────────────────────
const PRIORITY_COLORS = {
  high: "#ef4444",
  medium: "#f59e0b",
  low: "#22c55e",
};

const TaskCard = memo(function TaskCard({ task, onToggle, onDelete, onEdit }) {
  const { dark } = useContext(ThemeContext);
  const { dispatch } = useContext(TaskContext);

  // CONCEPT 7 — useCallback inside memo'd component
  const cyclePriority = useCallback(() => {
    const order = ["low", "medium", "high"];
    const next = order[(order.indexOf(task.priority) + 1) % 3];
    dispatch({ type: ACTIONS.SET_PRIORITY, payload: { id: task.id, priority: next } });
  }, [task.id, task.priority, dispatch]);

  return (
    <div
      style={{
        ...styles.card,
        ...(dark ? styles.cardDark : {}),
        opacity: task.done ? 0.55 : 1,
        borderLeft: `4px solid ${PRIORITY_COLORS[task.priority]}`,
      }}
    >
      {/* CONCEPT 13 — Lifting state: checkbox calls parent handler */}
      <input
        type="checkbox"
        checked={task.done}
        onChange={() => onToggle(task.id)}
        style={styles.checkbox}
      />
      <div style={styles.cardBody}>
        <span
          style={{
            ...styles.taskText,
            textDecoration: task.done ? "line-through" : "none",
            color: dark ? "#e2e8f0" : "#1e293b",
          }}
        >
          {task.text}
        </span>
        <div style={styles.tags}>
          <span style={{ ...styles.tag, background: dark ? "#334155" : "#f1f5f9" }}>
            {task.tag}
          </span>
          <button
            onClick={cyclePriority}
            style={{
              ...styles.priorityBadge,
              background: PRIORITY_COLORS[task.priority] + "22",
              color: PRIORITY_COLORS[task.priority],
            }}
            title="Click to cycle priority"
          >
            {task.priority}
          </button>
        </div>
      </div>
      <div style={styles.cardActions}>
        <button style={styles.iconBtn} onClick={() => onEdit(task)} title="Edit">
          ✏️
        </button>
        <button style={styles.iconBtn} onClick={() => onDelete(task.id)} title="Delete">
          🗑️
        </button>
      </div>
    </div>
  );
});

// ─────────────────────────────────────────────
// CONCEPT 14 — Composition: Card shell via children
// ─────────────────────────────────────────────
function Section({ title, children, dark }) {
  return (
    <div style={{ marginBottom: 24 }}>
      <h4 style={{ ...styles.sectionTitle, color: dark ? "#94a3b8" : "#64748b" }}>
        {title}
      </h4>
      {children}
    </div>
  );
}

// ─────────────────────────────────────────────
// ADD TASK FORM — controlled inputs + useRef
// ─────────────────────────────────────────────
function AddTaskForm() {
  const { dark } = useContext(ThemeContext);
  const { dispatch } = useContext(TaskContext);

  // CONCEPT 1 — multiple useState for form fields
  const [text, setText] = useState("");
  const [priority, setPriority] = useState("medium");
  const [tag, setTag] = useState("general");

  // CONCEPT 3 — useRef: focus input after adding
  const inputRef = useRef(null);

  const handleAdd = useCallback(() => {
    if (!text.trim()) return;
    dispatch({ type: ACTIONS.ADD, payload: { text: text.trim(), priority, tag } });
    setText("");
    inputRef.current?.focus();
  }, [text, priority, tag, dispatch]);

  return (
    <div style={{ ...styles.formBox, ...(dark ? styles.formBoxDark : {}) }}>
      <div style={styles.formRow}>
        <input
          ref={inputRef}
          value={text}
          onChange={(e) => setText(e.target.value)}
          onKeyDown={(e) => e.key === "Enter" && handleAdd()}
          placeholder="What needs to be done?"
          style={{ ...styles.input, flex: 1, ...(dark ? styles.inputDark : {}) }}
        />
        <select
          value={priority}
          onChange={(e) => setPriority(e.target.value)}
          style={{ ...styles.select, ...(dark ? styles.inputDark : {}) }}
        >
          <option value="high">🔴 High</option>
          <option value="medium">🟡 Medium</option>
          <option value="low">🟢 Low</option>
        </select>
        <select
          value={tag}
          onChange={(e) => setTag(e.target.value)}
          style={{ ...styles.select, ...(dark ? styles.inputDark : {}) }}
        >
          {["general", "work", "personal", "study", "health"].map((t) => (
            // CONCEPT 15 — Keys on list items
            <option key={t} value={t}>
              {t}
            </option>
          ))}
        </select>
      </div>
      <button
        style={{ ...styles.btnPrimary, width: "100%", marginTop: 10 }}
        onClick={handleAdd}
        disabled={!text.trim()}
      >
        + Add Task
      </button>
    </div>
  );
}

// ─────────────────────────────────────────────
// STATS BAR — useMemo for derived data
// ─────────────────────────────────────────────
function StatsBar({ tasks, dark }) {
  // CONCEPT 6 — useMemo: only recomputes when tasks change
  const stats = useMemo(() => {
    const done = tasks.filter((t) => t.done).length;
    const high = tasks.filter((t) => t.priority === "high" && !t.done).length;
    const pct = tasks.length ? Math.round((done / tasks.length) * 100) : 0;
    return { done, total: tasks.length, high, pct };
  }, [tasks]);

  return (
    <div style={styles.statsBar}>
      <div style={styles.statItem}>
        <span style={styles.statNum}>{stats.total}</span>
        <span style={{ ...styles.statLabel, color: dark ? "#94a3b8" : "#64748b" }}>Total</span>
      </div>
      <div style={styles.statItem}>
        <span style={{ ...styles.statNum, color: "#22c55e" }}>{stats.done}</span>
        <span style={{ ...styles.statLabel, color: dark ? "#94a3b8" : "#64748b" }}>Done</span>
      </div>
      <div style={styles.statItem}>
        <span style={{ ...styles.statNum, color: "#ef4444" }}>{stats.high}</span>
        <span style={{ ...styles.statLabel, color: dark ? "#94a3b8" : "#64748b" }}>High Priority</span>
      </div>
      <div style={{ ...styles.statItem, flex: 2 }}>
        <div style={styles.progressTrack}>
          <div
            style={{
              ...styles.progressFill,
              width: `${stats.pct}%`,
              background: stats.pct === 100 ? "#22c55e" : "#6366f1",
            }}
          />
        </div>
        <span style={{ ...styles.statLabel, color: dark ? "#94a3b8" : "#64748b" }}>
          {stats.pct}% complete
        </span>
      </div>
    </div>
  );
}

// ─────────────────────────────────────────────
// FILTER BAR — lifting state to App
// ─────────────────────────────────────────────
function FilterBar({ filter, setFilter, search, setSearch, dark }) {
  return (
    <div style={styles.filterBar}>
      <input
        value={search}
        onChange={(e) => setSearch(e.target.value)}
        placeholder="🔍 Search tasks..."
        style={{ ...styles.input, flex: 1, ...(dark ? styles.inputDark : {}) }}
      />
      {["all", "active", "done"].map((f) => (
        <button
          key={f}
          onClick={() => setFilter(f)}
          style={{
            ...styles.filterBtn,
            ...(filter === f ? styles.filterBtnActive : {}),
            color: dark && filter !== f ? "#94a3b8" : undefined,
          }}
        >
          {f}
        </button>
      ))}
    </div>
  );
}

// ─────────────────────────────────────────────
// MAIN APP
// ─────────────────────────────────────────────
function App() {
  const { dark, toggle } = useContext(ThemeContext);
  const { tasks, dispatch } = useContext(TaskContext);

  // CONCEPT 1 — useState for UI state (filter, search, modal)
  const [filter, setFilter] = useState("all");
  const [search, setSearch] = useState("");
  const [editingTask, setEditingTask] = useState(null);

  // CONCEPT 6 — useMemo: filtered + searched task list
  const visibleTasks = useMemo(() => {
    return tasks
      .filter((t) => {
        if (filter === "active") return !t.done;
        if (filter === "done") return t.done;
        return true;
      })
      .filter((t) =>
        t.text.toLowerCase().includes(search.toLowerCase())
      );
  }, [tasks, filter, search]);

  // CONCEPT 7 — useCallback: stable handlers passed to TaskCard (memo)
  const handleToggle = useCallback(
    (id) => dispatch({ type: ACTIONS.TOGGLE, payload: id }),
    [dispatch]
  );
  const handleDelete = useCallback(
    (id) => dispatch({ type: ACTIONS.DELETE, payload: id }),
    [dispatch]
  );
  const handleEdit = useCallback((task) => setEditingTask(task), []);
  const handleSaveEdit = useCallback(
    (text) => {
      if (text.trim() && editingTask) {
        dispatch({ type: ACTIONS.EDIT, payload: { id: editingTask.id, text: text.trim() } });
        setEditingTask(null);
      }
    },
    [editingTask, dispatch]
  );

  // CONCEPT 6 — useMemo: group visible tasks by tag
  const grouped = useMemo(() => {
    return visibleTasks.reduce((acc, t) => {
      (acc[t.tag] = acc[t.tag] || []).push(t);
      return acc;
    }, {});
  }, [visibleTasks]);

  return (
    <div style={{ ...styles.root, ...(dark ? styles.rootDark : {}) }}>
      {/* CONCEPT 11 — Portal: Modal */}
      {editingTask &&
        createPortal(
          <Modal
            task={editingTask}
            onClose={() => setEditingTask(null)}
            onSave={handleSaveEdit}
          />,
          document.body
        )}

      <div style={styles.container}>
        {/* HEADER */}
        <div style={styles.header}>
          <div>
            <h1 style={{ ...styles.title, color: dark ? "#f1f5f9" : "#0f172a" }}>
              ⚛️ React Mastery
            </h1>
            <p style={{ ...styles.subtitle, color: dark ? "#64748b" : "#94a3b8" }}>
              One project · Every concept
            </p>
          </div>
          <button onClick={toggle} style={styles.themeBtn} title="Toggle theme">
            {dark ? "☀️" : "🌙"}
          </button>
        </div>

        {/* CONCEPTS LEGEND */}
        <div style={{ ...styles.legend, ...(dark ? styles.legendDark : {}) }}>
          {[
            "useState", "useEffect", "useRef", "useReducer",
            "useContext", "useMemo", "useCallback", "Custom Hook",
            "Context API", "React.memo", "Portal", "Controlled Inputs",
            "Lifting State", "Composition", "Keys & Lists",
          ].map((c, i) => (
            <span key={c} style={styles.conceptBadge}>
              <span style={styles.conceptNum}>{i + 1}</span> {c}
            </span>
          ))}
        </div>

        {/* STATS */}
        <StatsBar tasks={tasks} dark={dark} />

        {/* ADD FORM */}
        <AddTaskForm />

        {/* FILTERS */}
        <FilterBar
          filter={filter}
          setFilter={setFilter}
          search={search}
          setSearch={setSearch}
          dark={dark}
        />

        {/* TASK LIST — grouped by tag (Composition + Keys) */}
        {visibleTasks.length === 0 ? (
          <div style={{ ...styles.empty, color: dark ? "#475569" : "#cbd5e1" }}>
            {search ? "No tasks match your search." : "No tasks yet — add one above!"}
          </div>
        ) : (
          Object.entries(grouped).map(([tag, tagTasks]) => (
            // CONCEPT 14 — Section as composition shell
            <Section key={tag} title={`# ${tag}`} dark={dark}>
              {tagTasks.map((task) => (
                // CONCEPT 15 — key prop for reconciliation
                // CONCEPT 10 — React.memo on TaskCard
                <TaskCard
                  key={task.id}
                  task={task}
                  onToggle={handleToggle}
                  onDelete={handleDelete}
                  onEdit={handleEdit}
                />
              ))}
            </Section>
          ))
        )}

        {/* CLEAR COMPLETED */}
        {tasks.some((t) => t.done) && (
          <button
            style={{ ...styles.clearBtn, color: dark ? "#64748b" : "#94a3b8" }}
            onClick={() =>
              tasks.filter((t) => t.done).forEach((t) =>
                dispatch({ type: ACTIONS.DELETE, payload: t.id })
              )
            }
          >
            Clear completed ({tasks.filter((t) => t.done).length})
          </button>
        )}

        {/* FOOTER — useRef demo */}
        <ConceptFooter dark={dark} />
      </div>
    </div>
  );
}

// ─────────────────────────────────────────────
// useRef demo: tracks render count without re-render
// ─────────────────────────────────────────────
function ConceptFooter({ dark }) {
  // CONCEPT 3 — useRef as mutable value (not state)
  const renderCount = useRef(0);
  renderCount.current += 1;

  // CONCEPT 2 — useEffect with no deps: runs every render
  useEffect(() => {
    // Intentionally left empty — renderCount.current updates
    // without triggering a re-render (that's the point of useRef!)
  });

  return (
    <div style={{ ...styles.footer, color: dark ? "#334155" : "#e2e8f0" }}>
      <span>
        🔁 App rendered <strong>{renderCount.current}×</strong> — tracked via{" "}
        <code>useRef</code> (no re-render on update)
      </span>
    </div>
  );
}

// ─────────────────────────────────────────────
// ROOT EXPORT with both providers
// ─────────────────────────────────────────────
export default function Root() {
  return (
    <ThemeProvider>
      <TaskProvider>
        <App />
      </TaskProvider>
    </ThemeProvider>
  );
}

// ─────────────────────────────────────────────
// STYLES
// ─────────────────────────────────────────────
const styles = {
  root: {
    minHeight: "100vh",
    background: "#f8fafc",
    fontFamily: "'DM Mono', 'Fira Code', monospace",
    transition: "background 0.3s, color 0.3s",
  },
  rootDark: { background: "#0f172a", color: "#e2e8f0" },
  container: { maxWidth: 740, margin: "0 auto", padding: "32px 16px 80px" },
  header: { display: "flex", justifyContent: "space-between", alignItems: "flex-start", marginBottom: 20 },
  title: { margin: 0, fontSize: 28, fontWeight: 800, letterSpacing: -1 },
  subtitle: { margin: "4px 0 0", fontSize: 13 },
  themeBtn: {
    fontSize: 22, background: "none", border: "none",
    cursor: "pointer", padding: "6px 10px", borderRadius: 8,
  },
  legend: {
    display: "flex", flexWrap: "wrap", gap: 6,
    background: "#f1f5f9", borderRadius: 12, padding: "12px 14px",
    marginBottom: 20,
  },
  legendDark: { background: "#1e293b" },
  conceptBadge: {
    fontSize: 11, background: "#e0e7ff", color: "#4338ca",
    borderRadius: 20, padding: "3px 9px", display: "flex",
    alignItems: "center", gap: 4, fontWeight: 600,
  },
  conceptNum: {
    background: "#6366f1", color: "#fff",
    borderRadius: "50%", width: 16, height: 16,
    display: "inline-flex", alignItems: "center", justifyContent: "center",
    fontSize: 9, fontWeight: 800,
  },
  statsBar: {
    display: "flex", gap: 12, alignItems: "center",
    marginBottom: 16, flexWrap: "wrap",
  },
  statItem: { display: "flex", flexDirection: "column", alignItems: "center", minWidth: 60 },
  statNum: { fontSize: 22, fontWeight: 800, lineHeight: 1 },
  statLabel: { fontSize: 11, marginTop: 2 },
  progressTrack: { width: "100%", height: 6, background: "#e2e8f0", borderRadius: 99, overflow: "hidden", minWidth: 100 },
  progressFill: { height: "100%", borderRadius: 99, transition: "width 0.4s ease" },
  formBox: {
    background: "#fff", border: "1px solid #e2e8f0",
    borderRadius: 14, padding: 16, marginBottom: 14,
    boxShadow: "0 1px 4px rgba(0,0,0,0.06)",
  },
  formBoxDark: { background: "#1e293b", border: "1px solid #334155" },
  formRow: { display: "flex", gap: 8, flexWrap: "wrap" },
  input: {
    padding: "9px 12px", borderRadius: 9, border: "1px solid #e2e8f0",
    fontSize: 14, outline: "none", background: "#f8fafc",
    fontFamily: "inherit", minWidth: 0,
  },
  inputDark: { background: "#0f172a", border: "1px solid #334155", color: "#e2e8f0" },
  select: {
    padding: "9px 10px", borderRadius: 9, border: "1px solid #e2e8f0",
    fontSize: 13, background: "#f8fafc", cursor: "pointer",
    fontFamily: "inherit",
  },
  btnPrimary: {
    padding: "9px 18px", background: "#6366f1", color: "#fff",
    border: "none", borderRadius: 9, fontWeight: 700,
    cursor: "pointer", fontSize: 14, fontFamily: "inherit",
    transition: "opacity 0.15s",
  },
  btnSecondary: {
    padding: "9px 18px", background: "transparent", border: "1px solid #e2e8f0",
    borderRadius: 9, fontWeight: 600, cursor: "pointer",
    fontSize: 14, fontFamily: "inherit",
  },
  filterBar: { display: "flex", gap: 8, marginBottom: 20, flexWrap: "wrap" },
  filterBtn: {
    padding: "7px 14px", borderRadius: 20, border: "1px solid #e2e8f0",
    background: "none", cursor: "pointer", fontSize: 13,
    fontWeight: 600, fontFamily: "inherit", textTransform: "capitalize",
  },
  filterBtnActive: { background: "#6366f1", color: "#fff", border: "1px solid #6366f1" },
  sectionTitle: { fontSize: 11, fontWeight: 700, textTransform: "uppercase", letterSpacing: 1, marginBottom: 8 },
  card: {
    display: "flex", alignItems: "center", gap: 12,
    background: "#fff", border: "1px solid #e2e8f0",
    borderRadius: 12, padding: "12px 14px", marginBottom: 8,
    boxShadow: "0 1px 3px rgba(0,0,0,0.05)", transition: "opacity 0.2s",
  },
  cardDark: { background: "#1e293b", border: "1px solid #334155" },
  checkbox: { width: 18, height: 18, cursor: "pointer", accentColor: "#6366f1", flexShrink: 0 },
  cardBody: { flex: 1, minWidth: 0 },
  taskText: { display: "block", fontSize: 14, fontWeight: 500, wordBreak: "break-word" },
  tags: { display: "flex", gap: 6, marginTop: 5, flexWrap: "wrap" },
  tag: { fontSize: 11, borderRadius: 20, padding: "2px 8px", fontWeight: 600 },
  priorityBadge: {
    fontSize: 11, borderRadius: 20, padding: "2px 8px",
    fontWeight: 700, border: "none", cursor: "pointer",
    fontFamily: "inherit",
  },
  cardActions: { display: "flex", gap: 4, flexShrink: 0 },
  iconBtn: {
    background: "none", border: "none", cursor: "pointer",
    fontSize: 14, padding: "4px 6px", borderRadius: 6,
  },
  empty: { textAlign: "center", padding: "48px 0", fontSize: 15, fontWeight: 500 },
  clearBtn: {
    background: "none", border: "none", cursor: "pointer",
    fontSize: 12, fontFamily: "inherit", marginTop: 8, padding: "6px 0",
    textDecoration: "underline",
  },
  footer: {
    marginTop: 40, textAlign: "center", fontSize: 12,
    padding: "16px", borderRadius: 10, background: "#f1f5f9",
  },
  overlay: {
    position: "fixed", inset: 0, background: "rgba(0,0,0,0.5)",
    display: "flex", alignItems: "center", justifyContent: "center",
    zIndex: 9999, backdropFilter: "blur(4px)",
  },
  modal: {
    background: "#fff", borderRadius: 16, padding: 28,
    width: "100%", maxWidth: 420, boxShadow: "0 20px 60px rgba(0,0,0,0.2)",
  },
  modalDark: { background: "#1e293b", color: "#e2e8f0" },
  modalTitle: { margin: "0 0 16px", fontSize: 18, fontWeight: 800 },
  modalActions: { display: "flex", gap: 10, justifyContent: "flex-end", marginTop: 16 },
};
