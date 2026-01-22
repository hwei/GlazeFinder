# 更新日志 | Changelog

本文件记录 GlazeFinder 的所有重要变更。

All notable changes to GlazeFinder will be documented in this file.

格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)，
版本号遵循 [语义化版本](https://semver.org/lang/zh-CN/)。

## [1.0.1] - 2026-01-22

### 修复 | Fixed
- 修复工作区名称包含方括号时解析错误的问题
  - Fixed workspace name parsing error when workspace names contain brackets
- 修复无法切换到最小化窗口的问题
  - Fixed inability to switch to minimized windows
- 修复目标工作区存在全屏窗口时切换失败的问题
  - Fixed switching failure when target workspace has fullscreen windows
- 改进错误处理，显示有意义的错误信息而不是隐藏所有输出
  - Improved error handling to show meaningful error messages instead of hiding all output

### 改进 | Improved
- 更好的解析逻辑，只移除格式化时添加的外层方括号
  - Better parsing logic to only remove outer brackets added during formatting
- 使用退出码检查命令执行状态
  - Use exit codes to check command execution status

## [1.0.0] - 2026-01-22

### 新增 | Added
- 初始发布 GlazeFinder
- 基于 fzf 的窗口切换功能
- 自动工作区和窗口聚焦
- UTF-8 编码支持，正确显示国际字符
- PowerShell 版本检查（需要 5.0+）
- 依赖检查（glazewm 和 fzf）
- 友好的错误提示和安装引导
- 完整的 PowerShell 文档（synopsis, description, examples）
- 一键安装脚本
- 一键卸载脚本

### 文档 | Documentation
- 中英双语 README
- MIT 开源许可证
- 贡献指南
- 更新日志

---

## 版本说明 | Version Notes

版本号格式：**主版本号.次版本号.修订号**

- **主版本号**：不兼容的 API 修改
- **次版本号**：向下兼容的功能性新增
- **修订号**：向下兼容的问题修正

---

[1.0.0]: https://github.com/hwei/GlazeFinder/releases/tag/v1.0.0