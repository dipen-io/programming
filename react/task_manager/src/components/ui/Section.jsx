export default function Section({ title, children }) {
  return (
    <div className="mb-6">
      <h4 className="text-xs font-bold uppercase tracking-widest text-slate-500 dark:text-slate-400 mb-3">
        {title}
      </h4>
      {children}
    </div>
  );
}
