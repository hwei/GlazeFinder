# 贡献指南 | Contributing to GlazeFinder

感谢你考虑为 GlazeFinder 做出贡献！

Thank you for considering contributing to GlazeFinder!

## 如何贡献 | How to Contribute

### 报告问题 | Reporting Issues

如果你发现了 bug 或有功能建议，请创建一个 Issue。提交 Issue 时请包含：

When reporting bugs or suggesting features, please create an Issue and include:

- **问题描述** | Description：清晰描述问题或建议
- **环境信息** | Environment：
  - PowerShell 版本（`$PSVersionTable.PSVersion`）
  - GlazeWM 版本（`glazewm --version`）
  - fzf 版本（`fzf --version`）
  - Windows 版本
- **重现步骤** | Steps to reproduce：如何复现该问题
- **预期行为** | Expected behavior：你期望发生什么
- **实际行为** | Actual behavior：实际发生了什么
- **错误信息** | Error messages：完整的错误信息（如有）

### 提交代码 | Submitting Code

1. **Fork 本仓库** | Fork the repository
2. **创建功能分支** | Create a feature branch
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **进行修改** | Make your changes
   - 保持代码风格一致
   - 添加必要的注释
   - 确保代码通过测试
4. **提交修改** | Commit your changes
   ```bash
   git commit -m "Add: your feature description"
   ```
5. **推送到你的 Fork** | Push to your fork
   ```bash
   git push origin feature/your-feature-name
   ```
6. **创建 Pull Request** | Create a Pull Request
   - 清晰描述你的更改
   - 引用相关的 Issue（如有）
   - 确保通过所有检查

## 代码风格 | Code Style

### PowerShell 代码规范

- 使用 **PascalCase** 命名函数：`Find-GlazeWindow`
- 使用 **camelCase** 命名变量：`$targetWindow`
- 添加完整的函数文档（`.SYNOPSIS`, `.DESCRIPTION`, `.EXAMPLE`）
- 使用 4 空格缩进
- 使用 `Write-Error`, `Write-Host` 等 PowerShell 标准输出
- 添加错误处理（try-catch）
- 提供有用的错误消息

### 注释规范

- 使用英文注释
- 注释应该解释"为什么"而不仅仅是"是什么"
- 对复杂逻辑添加行内注释

## 功能建议 | Feature Suggestions

我们欢迎以下类型的贡献：

We welcome contributions in the following areas:

- 🎨 **用户界面改进** | UI Improvements
  - fzf 预览窗口
  - 更好的格式化显示
  - 颜色主题支持

- ⚡ **性能优化** | Performance Optimizations
  - 更快的窗口查询
  - 缓存机制

- 🔧 **新功能** | New Features
  - 按工作区过滤
  - 按进程过滤
  - 自定义配置文件支持
  - 键盘快捷键定制

- 📚 **文档** | Documentation
  - 改进现有文档
  - 添加更多示例
  - 翻译（其他语言）

- 🧪 **测试** | Testing
  - 添加 Pester 测试
  - CI/CD 集成

## 开发环境设置 | Development Setup

1. **克隆仓库** | Clone the repository
   ```powershell
   git clone https://github.com/hwei/GlazeFinder.git
   cd GlazeFinder
   ```

2. **安装依赖** | Install dependencies
   - GlazeWM
   - fzf
   - PowerShell 5.0+

3. **测试你的更改** | Test your changes
   ```powershell
   # 加载脚本
   . .\GlazeFinder.ps1

   # 运行测试
   gf
   ```

## 提交信息规范 | Commit Message Guidelines

使用清晰的提交信息：

Use clear commit messages:

- `Add: 新功能` | `Add: new feature`
- `Fix: 修复问题` | `Fix: bug description`
- `Update: 更新内容` | `Update: what was updated`
- `Docs: 文档更新` | `Docs: documentation updates`
- `Refactor: 重构代码` | `Refactor: code refactoring`
- `Test: 添加测试` | `Test: add tests`

## 行为准则 | Code of Conduct

- 尊重所有贡献者
- 保持友好和专业
- 接受建设性的批评
- 关注对项目最有利的事情

Be respectful, friendly, and professional in all interactions.

## 问题和帮助 | Questions and Help

如果你有任何问题，可以：

If you have questions:

- 查看现有的 Issues
- 创建新的 Issue
- 在 Pull Request 中提问

## 许可证 | License

通过贡献代码，你同意你的贡献将按照 MIT 许可证授权。

By contributing, you agree that your contributions will be licensed under the MIT License.

---

再次感谢你的贡献！🎉

Thank you for contributing! 🎉
