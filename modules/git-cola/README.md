# README

To add a shortcut for the DAG just set this file:

```
/usr/share/git-cola/lib/cola/widgets/main.py
```

in such a way that it looks as follows:


```
        self.dag_action = add_action(self,
                N_('DAG...'), lambda: git_dag(self.model).show(), 'Ctrl+H')
        self.dag_action.setIcon(qtutils.git_icon())
```

That's all!


