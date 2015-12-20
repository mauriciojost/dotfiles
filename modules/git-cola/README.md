# README

To add a shortcut for the DAG just set this file:

```
/usr/share/git-cola/lib/cola/widgets/main.py
```

in such a way that it goes from:

```
        self.menu_dag = add_action(self,
                N_('DAG...'), lambda: git_dag(self.model).show())
```
to the following:

```
        self.dag_action = add_action(self,
                N_('DAG...'), lambda: git_dag(self.model).show(), 'Ctrl+H')
```

That's all!


