local LSP = {}

---@enum pasta.kit.LSP.SemanticTokenTypes
LSP.SemanticTokenTypes = {
  namespace = 'namespace',
  type = 'type',
  class = 'class',
  enum = 'enum',
  interface = 'interface',
  struct = 'struct',
  typeParameter = 'typeParameter',
  parameter = 'parameter',
  variable = 'variable',
  property = 'property',
  enumMember = 'enumMember',
  event = 'event',
  ['function'] = 'function',
  method = 'method',
  macro = 'macro',
  keyword = 'keyword',
  modifier = 'modifier',
  comment = 'comment',
  string = 'string',
  number = 'number',
  regexp = 'regexp',
  operator = 'operator',
  decorator = 'decorator',
}

---@enum pasta.kit.LSP.SemanticTokenModifiers
LSP.SemanticTokenModifiers = {
  declaration = 'declaration',
  definition = 'definition',
  readonly = 'readonly',
  static = 'static',
  deprecated = 'deprecated',
  abstract = 'abstract',
  async = 'async',
  modification = 'modification',
  documentation = 'documentation',
  defaultLibrary = 'defaultLibrary',
}

---@enum pasta.kit.LSP.DocumentDiagnosticReportKind
LSP.DocumentDiagnosticReportKind = {
  Full = 'full',
  Unchanged = 'unchanged',
}

---@enum pasta.kit.LSP.ErrorCodes
LSP.ErrorCodes = {
  ParseError = -32700,
  InvalidRequest = -32600,
  MethodNotFound = -32601,
  InvalidParams = -32602,
  InternalError = -32603,
  ServerNotInitialized = -32002,
  UnknownErrorCode = -32001,
}

---@enum pasta.kit.LSP.LSPErrorCodes
LSP.LSPErrorCodes = {
  RequestFailed = -32803,
  ServerCancelled = -32802,
  ContentModified = -32801,
  RequestCancelled = -32800,
}

---@enum pasta.kit.LSP.FoldingRangeKind
LSP.FoldingRangeKind = {
  Comment = 'comment',
  Imports = 'imports',
  Region = 'region',
}

---@enum pasta.kit.LSP.SymbolKind
LSP.SymbolKind = {
  File = 1,
  Module = 2,
  Namespace = 3,
  Package = 4,
  Class = 5,
  Method = 6,
  Property = 7,
  Field = 8,
  Constructor = 9,
  Enum = 10,
  Interface = 11,
  Function = 12,
  Variable = 13,
  Constant = 14,
  String = 15,
  Number = 16,
  Boolean = 17,
  Array = 18,
  Object = 19,
  Key = 20,
  Null = 21,
  EnumMember = 22,
  Struct = 23,
  Event = 24,
  Operator = 25,
  TypeParameter = 26,
}

---@enum pasta.kit.LSP.SymbolTag
LSP.SymbolTag = {
  Deprecated = 1,
}

---@enum pasta.kit.LSP.UniquenessLevel
LSP.UniquenessLevel = {
  document = 'document',
  project = 'project',
  group = 'group',
  scheme = 'scheme',
  global = 'global',
}

---@enum pasta.kit.LSP.MonikerKind
LSP.MonikerKind = {
  import = 'import',
  export = 'export',
  ['local'] = 'local',
}

---@enum pasta.kit.LSP.InlayHintKind
LSP.InlayHintKind = {
  Type = 1,
  Parameter = 2,
}

---@enum pasta.kit.LSP.MessageType
LSP.MessageType = {
  Error = 1,
  Warning = 2,
  Info = 3,
  Log = 4,
}

---@enum pasta.kit.LSP.TextDocumentSyncKind
LSP.TextDocumentSyncKind = {
  None = 0,
  Full = 1,
  Incremental = 2,
}

---@enum pasta.kit.LSP.TextDocumentSaveReason
LSP.TextDocumentSaveReason = {
  Manual = 1,
  AfterDelay = 2,
  FocusOut = 3,
}

---@enum pasta.kit.LSP.CompletionItemKind
LSP.CompletionItemKind = {
  Text = 1,
  Method = 2,
  Function = 3,
  Constructor = 4,
  Field = 5,
  Variable = 6,
  Class = 7,
  Interface = 8,
  Module = 9,
  Property = 10,
  Unit = 11,
  Value = 12,
  Enum = 13,
  Keyword = 14,
  Snippet = 15,
  Color = 16,
  File = 17,
  Reference = 18,
  Folder = 19,
  EnumMember = 20,
  Constant = 21,
  Struct = 22,
  Event = 23,
  Operator = 24,
  TypeParameter = 25,
}

---@enum pasta.kit.LSP.CompletionItemTag
LSP.CompletionItemTag = {
  Deprecated = 1,
}

---@enum pasta.kit.LSP.InsertTextFormat
LSP.InsertTextFormat = {
  PlainText = 1,
  Snippet = 2,
}

---@enum pasta.kit.LSP.InsertTextMode
LSP.InsertTextMode = {
  asIs = 1,
  adjustIndentation = 2,
}

---@enum pasta.kit.LSP.DocumentHighlightKind
LSP.DocumentHighlightKind = {
  Text = 1,
  Read = 2,
  Write = 3,
}

---@enum pasta.kit.LSP.CodeActionKind
LSP.CodeActionKind = {
  Empty = '',
  QuickFix = 'quickfix',
  Refactor = 'refactor',
  RefactorExtract = 'refactor.extract',
  RefactorInline = 'refactor.inline',
  RefactorRewrite = 'refactor.rewrite',
  Source = 'source',
  SourceOrganizeImports = 'source.organizeImports',
  SourceFixAll = 'source.fixAll',
}

---@enum pasta.kit.LSP.TraceValues
LSP.TraceValues = {
  Off = 'off',
  Messages = 'messages',
  Verbose = 'verbose',
}

---@enum pasta.kit.LSP.MarkupKind
LSP.MarkupKind = {
  PlainText = 'plaintext',
  Markdown = 'markdown',
}

---@enum pasta.kit.LSP.PositionEncodingKind
LSP.PositionEncodingKind = {
  UTF8 = 'utf-8',
  UTF16 = 'utf-16',
  UTF32 = 'utf-32',
}

---@enum pasta.kit.LSP.FileChangeType
LSP.FileChangeType = {
  Created = 1,
  Changed = 2,
  Deleted = 3,
}

---@enum pasta.kit.LSP.WatchKind
LSP.WatchKind = {
  Create = 1,
  Change = 2,
  Delete = 4,
}

---@enum pasta.kit.LSP.DiagnosticSeverity
LSP.DiagnosticSeverity = {
  Error = 1,
  Warning = 2,
  Information = 3,
  Hint = 4,
}

---@enum pasta.kit.LSP.DiagnosticTag
LSP.DiagnosticTag = {
  Unnecessary = 1,
  Deprecated = 2,
}

---@enum pasta.kit.LSP.CompletionTriggerKind
LSP.CompletionTriggerKind = {
  Invoked = 1,
  TriggerCharacter = 2,
  TriggerForIncompleteCompletions = 3,
}

---@enum pasta.kit.LSP.SignatureHelpTriggerKind
LSP.SignatureHelpTriggerKind = {
  Invoked = 1,
  TriggerCharacter = 2,
  ContentChange = 3,
}

---@enum pasta.kit.LSP.CodeActionTriggerKind
LSP.CodeActionTriggerKind = {
  Invoked = 1,
  Automatic = 2,
}

---@enum pasta.kit.LSP.FileOperationPatternKind
LSP.FileOperationPatternKind = {
  file = 'file',
  folder = 'folder',
}

---@enum pasta.kit.LSP.NotebookCellKind
LSP.NotebookCellKind = {
  Markup = 1,
  Code = 2,
}

---@enum pasta.kit.LSP.ResourceOperationKind
LSP.ResourceOperationKind = {
  Create = 'create',
  Rename = 'rename',
  Delete = 'delete',
}

---@enum pasta.kit.LSP.FailureHandlingKind
LSP.FailureHandlingKind = {
  Abort = 'abort',
  Transactional = 'transactional',
  TextOnlyTransactional = 'textOnlyTransactional',
  Undo = 'undo',
}

---@enum pasta.kit.LSP.PrepareSupportDefaultBehavior
LSP.PrepareSupportDefaultBehavior = {
  Identifier = 1,
}

---@enum pasta.kit.LSP.TokenFormat
LSP.TokenFormat = {
  Relative = 'relative',
}

---@class pasta.kit.LSP.ImplementationParams : pasta.kit.LSP.TextDocumentPositionParams

---@class pasta.kit.LSP.Location
---@field public uri string
---@field public range pasta.kit.LSP.Range

---@class pasta.kit.LSP.ImplementationRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.TypeDefinitionParams : pasta.kit.LSP.TextDocumentPositionParams

---@class pasta.kit.LSP.TypeDefinitionRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.WorkspaceFolder
---@field public uri string
---@field public name string

---@class pasta.kit.LSP.DidChangeWorkspaceFoldersParams
---@field public event pasta.kit.LSP.WorkspaceFoldersChangeEvent

---@class pasta.kit.LSP.ConfigurationParams
---@field public items pasta.kit.LSP.ConfigurationItem[]

---@class pasta.kit.LSP.PartialResultParams
---@field public partialResultToken? pasta.kit.LSP.ProgressToken

---@class pasta.kit.LSP.DocumentColorParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier

---@class pasta.kit.LSP.ColorInformation
---@field public range pasta.kit.LSP.Range
---@field public color pasta.kit.LSP.Color

---@class pasta.kit.LSP.DocumentColorRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.ColorPresentationParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier
---@field public color pasta.kit.LSP.Color
---@field public range pasta.kit.LSP.Range

---@class pasta.kit.LSP.ColorPresentation
---@field public label string
---@field public textEdit? pasta.kit.LSP.TextEdit
---@field public additionalTextEdits? pasta.kit.LSP.TextEdit[]

---@class pasta.kit.LSP.WorkDoneProgressOptions
---@field public workDoneProgress? boolean

---@class pasta.kit.LSP.TextDocumentRegistrationOptions
---@field public documentSelector (pasta.kit.LSP.DocumentSelector | nil)

---@class pasta.kit.LSP.FoldingRangeParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier

---@class pasta.kit.LSP.FoldingRange
---@field public startLine integer
---@field public startCharacter? integer
---@field public endLine integer
---@field public endCharacter? integer
---@field public kind? pasta.kit.LSP.FoldingRangeKind
---@field public collapsedText? string

---@class pasta.kit.LSP.FoldingRangeRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.DeclarationParams : pasta.kit.LSP.TextDocumentPositionParams

---@class pasta.kit.LSP.DeclarationRegistrationOptions : pasta.kit.LSP.DeclarationOptions

---@class pasta.kit.LSP.SelectionRangeParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier
---@field public positions pasta.kit.LSP.Position[]

---@class pasta.kit.LSP.SelectionRange
---@field public range pasta.kit.LSP.Range
---@field public parent? pasta.kit.LSP.SelectionRange

---@class pasta.kit.LSP.SelectionRangeRegistrationOptions : pasta.kit.LSP.SelectionRangeOptions

---@class pasta.kit.LSP.WorkDoneProgressCreateParams
---@field public token pasta.kit.LSP.ProgressToken

---@class pasta.kit.LSP.WorkDoneProgressCancelParams
---@field public token pasta.kit.LSP.ProgressToken

---@class pasta.kit.LSP.CallHierarchyPrepareParams : pasta.kit.LSP.TextDocumentPositionParams

---@class pasta.kit.LSP.CallHierarchyItem
---@field public name string
---@field public kind pasta.kit.LSP.SymbolKind
---@field public tags? pasta.kit.LSP.SymbolTag[]
---@field public detail? string
---@field public uri string
---@field public range pasta.kit.LSP.Range
---@field public selectionRange pasta.kit.LSP.Range
---@field public data? pasta.kit.LSP.LSPAny

---@class pasta.kit.LSP.CallHierarchyRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.CallHierarchyIncomingCallsParams
---@field public item pasta.kit.LSP.CallHierarchyItem

---@class pasta.kit.LSP.CallHierarchyIncomingCall
---@field public from pasta.kit.LSP.CallHierarchyItem
---@field public fromRanges pasta.kit.LSP.Range[]

---@class pasta.kit.LSP.CallHierarchyOutgoingCallsParams
---@field public item pasta.kit.LSP.CallHierarchyItem

---@class pasta.kit.LSP.CallHierarchyOutgoingCall
---@field public to pasta.kit.LSP.CallHierarchyItem
---@field public fromRanges pasta.kit.LSP.Range[]

---@class pasta.kit.LSP.SemanticTokensParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier

---@class pasta.kit.LSP.SemanticTokens
---@field public resultId? string
---@field public data integer[]

---@class pasta.kit.LSP.SemanticTokensPartialResult
---@field public data integer[]

---@class pasta.kit.LSP.SemanticTokensRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.SemanticTokensDeltaParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier
---@field public previousResultId string

---@class pasta.kit.LSP.SemanticTokensDelta
---@field public resultId? string
---@field public edits pasta.kit.LSP.SemanticTokensEdit[]

---@class pasta.kit.LSP.SemanticTokensDeltaPartialResult
---@field public edits pasta.kit.LSP.SemanticTokensEdit[]

---@class pasta.kit.LSP.SemanticTokensRangeParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier
---@field public range pasta.kit.LSP.Range

---@class pasta.kit.LSP.ShowDocumentParams
---@field public uri string
---@field public external? boolean
---@field public takeFocus? boolean
---@field public selection? pasta.kit.LSP.Range

---@class pasta.kit.LSP.ShowDocumentResult
---@field public success boolean

---@class pasta.kit.LSP.LinkedEditingRangeParams : pasta.kit.LSP.TextDocumentPositionParams

---@class pasta.kit.LSP.LinkedEditingRanges
---@field public ranges pasta.kit.LSP.Range[]
---@field public wordPattern? string

---@class pasta.kit.LSP.LinkedEditingRangeRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.CreateFilesParams
---@field public files pasta.kit.LSP.FileCreate[]

---@class pasta.kit.LSP.WorkspaceEdit
---@field public changes? table<string, pasta.kit.LSP.TextEdit[]>
---@field public documentChanges? (pasta.kit.LSP.TextDocumentEdit | pasta.kit.LSP.CreateFile | pasta.kit.LSP.RenameFile | pasta.kit.LSP.DeleteFile)[]
---@field public changeAnnotations? table<pasta.kit.LSP.ChangeAnnotationIdentifier, pasta.kit.LSP.ChangeAnnotation>

---@class pasta.kit.LSP.FileOperationRegistrationOptions
---@field public filters pasta.kit.LSP.FileOperationFilter[]

---@class pasta.kit.LSP.RenameFilesParams
---@field public files pasta.kit.LSP.FileRename[]

---@class pasta.kit.LSP.DeleteFilesParams
---@field public files pasta.kit.LSP.FileDelete[]

---@class pasta.kit.LSP.MonikerParams : pasta.kit.LSP.TextDocumentPositionParams

---@class pasta.kit.LSP.Moniker
---@field public scheme string
---@field public identifier string
---@field public unique pasta.kit.LSP.UniquenessLevel
---@field public kind? pasta.kit.LSP.MonikerKind

---@class pasta.kit.LSP.MonikerRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.TypeHierarchyPrepareParams : pasta.kit.LSP.TextDocumentPositionParams

---@class pasta.kit.LSP.TypeHierarchyItem
---@field public name string
---@field public kind pasta.kit.LSP.SymbolKind
---@field public tags? pasta.kit.LSP.SymbolTag[]
---@field public detail? string
---@field public uri string
---@field public range pasta.kit.LSP.Range
---@field public selectionRange pasta.kit.LSP.Range
---@field public data? pasta.kit.LSP.LSPAny

---@class pasta.kit.LSP.TypeHierarchyRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.TypeHierarchySupertypesParams
---@field public item pasta.kit.LSP.TypeHierarchyItem

---@class pasta.kit.LSP.TypeHierarchySubtypesParams
---@field public item pasta.kit.LSP.TypeHierarchyItem

---@class pasta.kit.LSP.InlineValueParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier
---@field public range pasta.kit.LSP.Range
---@field public context pasta.kit.LSP.InlineValueContext

---@class pasta.kit.LSP.InlineValueRegistrationOptions : pasta.kit.LSP.InlineValueOptions

---@class pasta.kit.LSP.InlayHintParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier
---@field public range pasta.kit.LSP.Range

---@class pasta.kit.LSP.InlayHint
---@field public position pasta.kit.LSP.Position
---@field public label (string | pasta.kit.LSP.InlayHintLabelPart[])
---@field public kind? pasta.kit.LSP.InlayHintKind
---@field public textEdits? pasta.kit.LSP.TextEdit[]
---@field public tooltip? (string | pasta.kit.LSP.MarkupContent)
---@field public paddingLeft? boolean
---@field public paddingRight? boolean
---@field public data? pasta.kit.LSP.LSPAny

---@class pasta.kit.LSP.InlayHintRegistrationOptions : pasta.kit.LSP.InlayHintOptions

---@class pasta.kit.LSP.DocumentDiagnosticParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier
---@field public identifier? string
---@field public previousResultId? string

---@class pasta.kit.LSP.DocumentDiagnosticReportPartialResult
---@field public relatedDocuments table<string, (pasta.kit.LSP.FullDocumentDiagnosticReport | pasta.kit.LSP.UnchangedDocumentDiagnosticReport)>

---@class pasta.kit.LSP.DiagnosticServerCancellationData
---@field public retriggerRequest boolean

---@class pasta.kit.LSP.DiagnosticRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.WorkspaceDiagnosticParams
---@field public identifier? string
---@field public previousResultIds pasta.kit.LSP.PreviousResultId[]

---@class pasta.kit.LSP.WorkspaceDiagnosticReport
---@field public items pasta.kit.LSP.WorkspaceDocumentDiagnosticReport[]

---@class pasta.kit.LSP.WorkspaceDiagnosticReportPartialResult
---@field public items pasta.kit.LSP.WorkspaceDocumentDiagnosticReport[]

---@class pasta.kit.LSP.DidOpenNotebookDocumentParams
---@field public notebookDocument pasta.kit.LSP.NotebookDocument
---@field public cellTextDocuments pasta.kit.LSP.TextDocumentItem[]

---@class pasta.kit.LSP.DidChangeNotebookDocumentParams
---@field public notebookDocument pasta.kit.LSP.VersionedNotebookDocumentIdentifier
---@field public change pasta.kit.LSP.NotebookDocumentChangeEvent

---@class pasta.kit.LSP.DidSaveNotebookDocumentParams
---@field public notebookDocument pasta.kit.LSP.NotebookDocumentIdentifier

---@class pasta.kit.LSP.DidCloseNotebookDocumentParams
---@field public notebookDocument pasta.kit.LSP.NotebookDocumentIdentifier
---@field public cellTextDocuments pasta.kit.LSP.TextDocumentIdentifier[]

---@class pasta.kit.LSP.RegistrationParams
---@field public registrations pasta.kit.LSP.Registration[]

---@class pasta.kit.LSP.UnregistrationParams
---@field public unregisterations pasta.kit.LSP.Unregistration[]

---@class pasta.kit.LSP.InitializeParams : pasta.kit.LSP._InitializeParams

---@class pasta.kit.LSP.InitializeResult
---@field public capabilities pasta.kit.LSP.ServerCapabilities
---@field public serverInfo? { name: string, version?: string }

---@class pasta.kit.LSP.InitializeError
---@field public retry boolean

---@class pasta.kit.LSP.InitializedParams

---@class pasta.kit.LSP.DidChangeConfigurationParams
---@field public settings pasta.kit.LSP.LSPAny

---@class pasta.kit.LSP.DidChangeConfigurationRegistrationOptions
---@field public section? (string | string[])

---@class pasta.kit.LSP.ShowMessageParams
---@field public type pasta.kit.LSP.MessageType
---@field public message string

---@class pasta.kit.LSP.ShowMessageRequestParams
---@field public type pasta.kit.LSP.MessageType
---@field public message string
---@field public actions? pasta.kit.LSP.MessageActionItem[]

---@class pasta.kit.LSP.MessageActionItem
---@field public title string

---@class pasta.kit.LSP.LogMessageParams
---@field public type pasta.kit.LSP.MessageType
---@field public message string

---@class pasta.kit.LSP.DidOpenTextDocumentParams
---@field public textDocument pasta.kit.LSP.TextDocumentItem

---@class pasta.kit.LSP.DidChangeTextDocumentParams
---@field public textDocument pasta.kit.LSP.VersionedTextDocumentIdentifier
---@field public contentChanges pasta.kit.LSP.TextDocumentContentChangeEvent[]

---@class pasta.kit.LSP.TextDocumentChangeRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions
---@field public syncKind pasta.kit.LSP.TextDocumentSyncKind

---@class pasta.kit.LSP.DidCloseTextDocumentParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier

---@class pasta.kit.LSP.DidSaveTextDocumentParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier
---@field public text? string

---@class pasta.kit.LSP.TextDocumentSaveRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.WillSaveTextDocumentParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier
---@field public reason pasta.kit.LSP.TextDocumentSaveReason

---@class pasta.kit.LSP.TextEdit
---@field public range pasta.kit.LSP.Range
---@field public newText string

---@class pasta.kit.LSP.DidChangeWatchedFilesParams
---@field public changes pasta.kit.LSP.FileEvent[]

---@class pasta.kit.LSP.DidChangeWatchedFilesRegistrationOptions
---@field public watchers pasta.kit.LSP.FileSystemWatcher[]

---@class pasta.kit.LSP.PublishDiagnosticsParams
---@field public uri string
---@field public version? integer
---@field public diagnostics pasta.kit.LSP.Diagnostic[]

---@class pasta.kit.LSP.CompletionParams : pasta.kit.LSP.TextDocumentPositionParams
---@field public context? pasta.kit.LSP.CompletionContext

---@class pasta.kit.LSP.CompletionItem
---@field public label string
---@field public labelDetails? pasta.kit.LSP.CompletionItemLabelDetails
---@field public kind? pasta.kit.LSP.CompletionItemKind
---@field public tags? pasta.kit.LSP.CompletionItemTag[]
---@field public detail? string
---@field public documentation? (string | pasta.kit.LSP.MarkupContent)
---@field public deprecated? boolean
---@field public preselect? boolean
---@field public sortText? string
---@field public filterText? string
---@field public insertText? string
---@field public insertTextFormat? pasta.kit.LSP.InsertTextFormat
---@field public insertTextMode? pasta.kit.LSP.InsertTextMode
---@field public textEdit? (pasta.kit.LSP.TextEdit | pasta.kit.LSP.InsertReplaceEdit)
---@field public textEditText? string
---@field public additionalTextEdits? pasta.kit.LSP.TextEdit[]
---@field public commitCharacters? string[]
---@field public command? pasta.kit.LSP.Command
---@field public data? pasta.kit.LSP.LSPAny

---@class pasta.kit.LSP.CompletionList
---@field public isIncomplete boolean
---@field public itemDefaults? { commitCharacters?: string[], editRange?: (pasta.kit.LSP.Range | { insert: pasta.kit.LSP.Range, replace: pasta.kit.LSP.Range }), insertTextFormat?: pasta.kit.LSP.InsertTextFormat, insertTextMode?: pasta.kit.LSP.InsertTextMode, data?: pasta.kit.LSP.LSPAny }
---@field public items pasta.kit.LSP.CompletionItem[]

---@class pasta.kit.LSP.CompletionRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.HoverParams : pasta.kit.LSP.TextDocumentPositionParams

---@class pasta.kit.LSP.Hover
---@field public contents (pasta.kit.LSP.MarkupContent | pasta.kit.LSP.MarkedString | pasta.kit.LSP.MarkedString[])
---@field public range? pasta.kit.LSP.Range

---@class pasta.kit.LSP.HoverRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.SignatureHelpParams : pasta.kit.LSP.TextDocumentPositionParams
---@field public context? pasta.kit.LSP.SignatureHelpContext

---@class pasta.kit.LSP.SignatureHelp
---@field public signatures pasta.kit.LSP.SignatureInformation[]
---@field public activeSignature? integer
---@field public activeParameter? integer

---@class pasta.kit.LSP.SignatureHelpRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.DefinitionParams : pasta.kit.LSP.TextDocumentPositionParams

---@class pasta.kit.LSP.DefinitionRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.ReferenceParams : pasta.kit.LSP.TextDocumentPositionParams
---@field public context pasta.kit.LSP.ReferenceContext

---@class pasta.kit.LSP.ReferenceRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.DocumentHighlightParams : pasta.kit.LSP.TextDocumentPositionParams

---@class pasta.kit.LSP.DocumentHighlight
---@field public range pasta.kit.LSP.Range
---@field public kind? pasta.kit.LSP.DocumentHighlightKind

---@class pasta.kit.LSP.DocumentHighlightRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.DocumentSymbolParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier

---@class pasta.kit.LSP.SymbolInformation : pasta.kit.LSP.BaseSymbolInformation
---@field public deprecated? boolean
---@field public location pasta.kit.LSP.Location

---@class pasta.kit.LSP.DocumentSymbol
---@field public name string
---@field public detail? string
---@field public kind pasta.kit.LSP.SymbolKind
---@field public tags? pasta.kit.LSP.SymbolTag[]
---@field public deprecated? boolean
---@field public range pasta.kit.LSP.Range
---@field public selectionRange pasta.kit.LSP.Range
---@field public children? pasta.kit.LSP.DocumentSymbol[]

---@class pasta.kit.LSP.DocumentSymbolRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.CodeActionParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier
---@field public range pasta.kit.LSP.Range
---@field public context pasta.kit.LSP.CodeActionContext

---@class pasta.kit.LSP.Command
---@field public title string
---@field public command string
---@field public arguments? pasta.kit.LSP.LSPAny[]

---@class pasta.kit.LSP.CodeAction
---@field public title string
---@field public kind? pasta.kit.LSP.CodeActionKind
---@field public diagnostics? pasta.kit.LSP.Diagnostic[]
---@field public isPreferred? boolean
---@field public disabled? { reason: string }
---@field public edit? pasta.kit.LSP.WorkspaceEdit
---@field public command? pasta.kit.LSP.Command
---@field public data? pasta.kit.LSP.LSPAny

---@class pasta.kit.LSP.CodeActionRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.WorkspaceSymbolParams
---@field public query string

---@class pasta.kit.LSP.WorkspaceSymbol : pasta.kit.LSP.BaseSymbolInformation
---@field public location (pasta.kit.LSP.Location | { uri: string })
---@field public data? pasta.kit.LSP.LSPAny

---@class pasta.kit.LSP.WorkspaceSymbolRegistrationOptions : pasta.kit.LSP.WorkspaceSymbolOptions

---@class pasta.kit.LSP.CodeLensParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier

---@class pasta.kit.LSP.CodeLens
---@field public range pasta.kit.LSP.Range
---@field public command? pasta.kit.LSP.Command
---@field public data? pasta.kit.LSP.LSPAny

---@class pasta.kit.LSP.CodeLensRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.DocumentLinkParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier

---@class pasta.kit.LSP.DocumentLink
---@field public range pasta.kit.LSP.Range
---@field public target? string
---@field public tooltip? string
---@field public data? pasta.kit.LSP.LSPAny

---@class pasta.kit.LSP.DocumentLinkRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.DocumentFormattingParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier
---@field public options pasta.kit.LSP.FormattingOptions

---@class pasta.kit.LSP.DocumentFormattingRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.DocumentRangeFormattingParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier
---@field public range pasta.kit.LSP.Range
---@field public options pasta.kit.LSP.FormattingOptions

---@class pasta.kit.LSP.DocumentRangeFormattingRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.DocumentOnTypeFormattingParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier
---@field public position pasta.kit.LSP.Position
---@field public ch string
---@field public options pasta.kit.LSP.FormattingOptions

---@class pasta.kit.LSP.DocumentOnTypeFormattingRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.RenameParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier
---@field public position pasta.kit.LSP.Position
---@field public newName string

---@class pasta.kit.LSP.RenameRegistrationOptions : pasta.kit.LSP.TextDocumentRegistrationOptions

---@class pasta.kit.LSP.PrepareRenameParams : pasta.kit.LSP.TextDocumentPositionParams

---@class pasta.kit.LSP.ExecuteCommandParams
---@field public command string
---@field public arguments? pasta.kit.LSP.LSPAny[]

---@class pasta.kit.LSP.ExecuteCommandRegistrationOptions : pasta.kit.LSP.ExecuteCommandOptions

---@class pasta.kit.LSP.ApplyWorkspaceEditParams
---@field public label? string
---@field public edit pasta.kit.LSP.WorkspaceEdit

---@class pasta.kit.LSP.ApplyWorkspaceEditResult
---@field public applied boolean
---@field public failureReason? string
---@field public failedChange? integer

---@class pasta.kit.LSP.WorkDoneProgressBegin
---@field public kind "begin"
---@field public title string
---@field public cancellable? boolean
---@field public message? string
---@field public percentage? integer

---@class pasta.kit.LSP.WorkDoneProgressReport
---@field public kind "report"
---@field public cancellable? boolean
---@field public message? string
---@field public percentage? integer

---@class pasta.kit.LSP.WorkDoneProgressEnd
---@field public kind "end"
---@field public message? string

---@class pasta.kit.LSP.SetTraceParams
---@field public value pasta.kit.LSP.TraceValues

---@class pasta.kit.LSP.LogTraceParams
---@field public message string
---@field public verbose? string

---@class pasta.kit.LSP.CancelParams
---@field public id (integer | string)

---@class pasta.kit.LSP.ProgressParams
---@field public token pasta.kit.LSP.ProgressToken
---@field public value pasta.kit.LSP.LSPAny

---@class pasta.kit.LSP.TextDocumentPositionParams
---@field public textDocument pasta.kit.LSP.TextDocumentIdentifier
---@field public position pasta.kit.LSP.Position

---@class pasta.kit.LSP.WorkDoneProgressParams
---@field public workDoneToken? pasta.kit.LSP.ProgressToken

---@class pasta.kit.LSP.LocationLink
---@field public originSelectionRange? pasta.kit.LSP.Range
---@field public targetUri string
---@field public targetRange pasta.kit.LSP.Range
---@field public targetSelectionRange pasta.kit.LSP.Range

---@class pasta.kit.LSP.Range
---@field public start pasta.kit.LSP.Position
---@field public end pasta.kit.LSP.Position

---@class pasta.kit.LSP.ImplementationOptions

---@class pasta.kit.LSP.StaticRegistrationOptions
---@field public id? string

---@class pasta.kit.LSP.TypeDefinitionOptions

---@class pasta.kit.LSP.WorkspaceFoldersChangeEvent
---@field public added pasta.kit.LSP.WorkspaceFolder[]
---@field public removed pasta.kit.LSP.WorkspaceFolder[]

---@class pasta.kit.LSP.ConfigurationItem
---@field public scopeUri? string
---@field public section? string

---@class pasta.kit.LSP.TextDocumentIdentifier
---@field public uri string

---@class pasta.kit.LSP.Color
---@field public red integer
---@field public green integer
---@field public blue integer
---@field public alpha integer

---@class pasta.kit.LSP.DocumentColorOptions

---@class pasta.kit.LSP.FoldingRangeOptions

---@class pasta.kit.LSP.DeclarationOptions

---@class pasta.kit.LSP.Position
---@field public line integer
---@field public character integer

---@class pasta.kit.LSP.SelectionRangeOptions

---@class pasta.kit.LSP.CallHierarchyOptions

---@class pasta.kit.LSP.SemanticTokensOptions
---@field public legend pasta.kit.LSP.SemanticTokensLegend
---@field public range? (boolean | {  })
---@field public full? (boolean | { delta?: boolean })

---@class pasta.kit.LSP.SemanticTokensEdit
---@field public start integer
---@field public deleteCount integer
---@field public data? integer[]

---@class pasta.kit.LSP.LinkedEditingRangeOptions

---@class pasta.kit.LSP.FileCreate
---@field public uri string

---@class pasta.kit.LSP.TextDocumentEdit
---@field public textDocument pasta.kit.LSP.OptionalVersionedTextDocumentIdentifier
---@field public edits (pasta.kit.LSP.TextEdit | pasta.kit.LSP.AnnotatedTextEdit)[]

---@class pasta.kit.LSP.CreateFile : pasta.kit.LSP.ResourceOperation
---@field public kind "create"
---@field public uri string
---@field public options? pasta.kit.LSP.CreateFileOptions

---@class pasta.kit.LSP.RenameFile : pasta.kit.LSP.ResourceOperation
---@field public kind "rename"
---@field public oldUri string
---@field public newUri string
---@field public options? pasta.kit.LSP.RenameFileOptions

---@class pasta.kit.LSP.DeleteFile : pasta.kit.LSP.ResourceOperation
---@field public kind "delete"
---@field public uri string
---@field public options? pasta.kit.LSP.DeleteFileOptions

---@class pasta.kit.LSP.ChangeAnnotation
---@field public label string
---@field public needsConfirmation? boolean
---@field public description? string

---@class pasta.kit.LSP.FileOperationFilter
---@field public scheme? string
---@field public pattern pasta.kit.LSP.FileOperationPattern

---@class pasta.kit.LSP.FileRename
---@field public oldUri string
---@field public newUri string

---@class pasta.kit.LSP.FileDelete
---@field public uri string

---@class pasta.kit.LSP.MonikerOptions

---@class pasta.kit.LSP.TypeHierarchyOptions

---@class pasta.kit.LSP.InlineValueContext
---@field public frameId integer
---@field public stoppedLocation pasta.kit.LSP.Range

---@class pasta.kit.LSP.InlineValueText
---@field public range pasta.kit.LSP.Range
---@field public text string

---@class pasta.kit.LSP.InlineValueVariableLookup
---@field public range pasta.kit.LSP.Range
---@field public variableName? string
---@field public caseSensitiveLookup boolean

---@class pasta.kit.LSP.InlineValueEvaluatableExpression
---@field public range pasta.kit.LSP.Range
---@field public expression? string

---@class pasta.kit.LSP.InlineValueOptions

---@class pasta.kit.LSP.InlayHintLabelPart
---@field public value string
---@field public tooltip? (string | pasta.kit.LSP.MarkupContent)
---@field public location? pasta.kit.LSP.Location
---@field public command? pasta.kit.LSP.Command

---@class pasta.kit.LSP.MarkupContent
---@field public kind pasta.kit.LSP.MarkupKind
---@field public value string

---@class pasta.kit.LSP.InlayHintOptions
---@field public resolveProvider? boolean

---@class pasta.kit.LSP.RelatedFullDocumentDiagnosticReport : pasta.kit.LSP.FullDocumentDiagnosticReport
---@field public relatedDocuments? table<string, (pasta.kit.LSP.FullDocumentDiagnosticReport | pasta.kit.LSP.UnchangedDocumentDiagnosticReport)>

---@class pasta.kit.LSP.RelatedUnchangedDocumentDiagnosticReport : pasta.kit.LSP.UnchangedDocumentDiagnosticReport
---@field public relatedDocuments? table<string, (pasta.kit.LSP.FullDocumentDiagnosticReport | pasta.kit.LSP.UnchangedDocumentDiagnosticReport)>

---@class pasta.kit.LSP.FullDocumentDiagnosticReport
---@field public kind "full"
---@field public resultId? string
---@field public items pasta.kit.LSP.Diagnostic[]

---@class pasta.kit.LSP.UnchangedDocumentDiagnosticReport
---@field public kind "unchanged"
---@field public resultId string

---@class pasta.kit.LSP.DiagnosticOptions
---@field public identifier? string
---@field public interFileDependencies boolean
---@field public workspaceDiagnostics boolean

---@class pasta.kit.LSP.PreviousResultId
---@field public uri string
---@field public value string

---@class pasta.kit.LSP.NotebookDocument
---@field public uri string
---@field public notebookType string
---@field public version integer
---@field public metadata? pasta.kit.LSP.LSPObject
---@field public cells pasta.kit.LSP.NotebookCell[]

---@class pasta.kit.LSP.TextDocumentItem
---@field public uri string
---@field public languageId string
---@field public version integer
---@field public text string

---@class pasta.kit.LSP.VersionedNotebookDocumentIdentifier
---@field public version integer
---@field public uri string

---@class pasta.kit.LSP.NotebookDocumentChangeEvent
---@field public metadata? pasta.kit.LSP.LSPObject
---@field public cells? { structure?: { array: pasta.kit.LSP.NotebookCellArrayChange, didOpen?: pasta.kit.LSP.TextDocumentItem[], didClose?: pasta.kit.LSP.TextDocumentIdentifier[] }, data?: pasta.kit.LSP.NotebookCell[], textContent?: { document: pasta.kit.LSP.VersionedTextDocumentIdentifier, changes: pasta.kit.LSP.TextDocumentContentChangeEvent[] }[] }

---@class pasta.kit.LSP.NotebookDocumentIdentifier
---@field public uri string

---@class pasta.kit.LSP.Registration
---@field public id string
---@field public method string
---@field public registerOptions? pasta.kit.LSP.LSPAny

---@class pasta.kit.LSP.Unregistration
---@field public id string
---@field public method string

---@class pasta.kit.LSP._InitializeParams
---@field public processId (integer | nil)
---@field public clientInfo? { name: string, version?: string }
---@field public locale? string
---@field public rootPath? (string | nil)
---@field public rootUri (string | nil)
---@field public capabilities pasta.kit.LSP.ClientCapabilities
---@field public initializationOptions? pasta.kit.LSP.LSPAny
---@field public trace? ("off" | "messages" | "compact" | "verbose")

---@class pasta.kit.LSP.WorkspaceFoldersInitializeParams
---@field public workspaceFolders? (pasta.kit.LSP.WorkspaceFolder[] | nil)

---@class pasta.kit.LSP.ServerCapabilities
---@field public positionEncoding? pasta.kit.LSP.PositionEncodingKind
---@field public textDocumentSync? (pasta.kit.LSP.TextDocumentSyncOptions | pasta.kit.LSP.TextDocumentSyncKind)
---@field public notebookDocumentSync? (pasta.kit.LSP.NotebookDocumentSyncOptions | pasta.kit.LSP.NotebookDocumentSyncRegistrationOptions)
---@field public completionProvider? pasta.kit.LSP.CompletionOptions
---@field public hoverProvider? (boolean | pasta.kit.LSP.HoverOptions)
---@field public signatureHelpProvider? pasta.kit.LSP.SignatureHelpOptions
---@field public declarationProvider? (boolean | pasta.kit.LSP.DeclarationOptions | pasta.kit.LSP.DeclarationRegistrationOptions)
---@field public definitionProvider? (boolean | pasta.kit.LSP.DefinitionOptions)
---@field public typeDefinitionProvider? (boolean | pasta.kit.LSP.TypeDefinitionOptions | pasta.kit.LSP.TypeDefinitionRegistrationOptions)
---@field public implementationProvider? (boolean | pasta.kit.LSP.ImplementationOptions | pasta.kit.LSP.ImplementationRegistrationOptions)
---@field public referencesProvider? (boolean | pasta.kit.LSP.ReferenceOptions)
---@field public documentHighlightProvider? (boolean | pasta.kit.LSP.DocumentHighlightOptions)
---@field public documentSymbolProvider? (boolean | pasta.kit.LSP.DocumentSymbolOptions)
---@field public codeActionProvider? (boolean | pasta.kit.LSP.CodeActionOptions)
---@field public codeLensProvider? pasta.kit.LSP.CodeLensOptions
---@field public documentLinkProvider? pasta.kit.LSP.DocumentLinkOptions
---@field public colorProvider? (boolean | pasta.kit.LSP.DocumentColorOptions | pasta.kit.LSP.DocumentColorRegistrationOptions)
---@field public workspaceSymbolProvider? (boolean | pasta.kit.LSP.WorkspaceSymbolOptions)
---@field public documentFormattingProvider? (boolean | pasta.kit.LSP.DocumentFormattingOptions)
---@field public documentRangeFormattingProvider? (boolean | pasta.kit.LSP.DocumentRangeFormattingOptions)
---@field public documentOnTypeFormattingProvider? pasta.kit.LSP.DocumentOnTypeFormattingOptions
---@field public renameProvider? (boolean | pasta.kit.LSP.RenameOptions)
---@field public foldingRangeProvider? (boolean | pasta.kit.LSP.FoldingRangeOptions | pasta.kit.LSP.FoldingRangeRegistrationOptions)
---@field public selectionRangeProvider? (boolean | pasta.kit.LSP.SelectionRangeOptions | pasta.kit.LSP.SelectionRangeRegistrationOptions)
---@field public executeCommandProvider? pasta.kit.LSP.ExecuteCommandOptions
---@field public callHierarchyProvider? (boolean | pasta.kit.LSP.CallHierarchyOptions | pasta.kit.LSP.CallHierarchyRegistrationOptions)
---@field public linkedEditingRangeProvider? (boolean | pasta.kit.LSP.LinkedEditingRangeOptions | pasta.kit.LSP.LinkedEditingRangeRegistrationOptions)
---@field public semanticTokensProvider? (pasta.kit.LSP.SemanticTokensOptions | pasta.kit.LSP.SemanticTokensRegistrationOptions)
---@field public monikerProvider? (boolean | pasta.kit.LSP.MonikerOptions | pasta.kit.LSP.MonikerRegistrationOptions)
---@field public typeHierarchyProvider? (boolean | pasta.kit.LSP.TypeHierarchyOptions | pasta.kit.LSP.TypeHierarchyRegistrationOptions)
---@field public inlineValueProvider? (boolean | pasta.kit.LSP.InlineValueOptions | pasta.kit.LSP.InlineValueRegistrationOptions)
---@field public inlayHintProvider? (boolean | pasta.kit.LSP.InlayHintOptions | pasta.kit.LSP.InlayHintRegistrationOptions)
---@field public diagnosticProvider? (pasta.kit.LSP.DiagnosticOptions | pasta.kit.LSP.DiagnosticRegistrationOptions)
---@field public workspace? { workspaceFolders?: pasta.kit.LSP.WorkspaceFoldersServerCapabilities, fileOperations?: pasta.kit.LSP.FileOperationOptions }
---@field public experimental? pasta.kit.LSP.LSPAny

---@class pasta.kit.LSP.VersionedTextDocumentIdentifier : pasta.kit.LSP.TextDocumentIdentifier
---@field public version integer

---@class pasta.kit.LSP.SaveOptions
---@field public includeText? boolean

---@class pasta.kit.LSP.FileEvent
---@field public uri string
---@field public type pasta.kit.LSP.FileChangeType

---@class pasta.kit.LSP.FileSystemWatcher
---@field public globPattern pasta.kit.LSP.GlobPattern
---@field public kind? pasta.kit.LSP.WatchKind

---@class pasta.kit.LSP.Diagnostic
---@field public range pasta.kit.LSP.Range
---@field public severity? pasta.kit.LSP.DiagnosticSeverity
---@field public code? (integer | string)
---@field public codeDescription? pasta.kit.LSP.CodeDescription
---@field public source? string
---@field public message string
---@field public tags? pasta.kit.LSP.DiagnosticTag[]
---@field public relatedInformation? pasta.kit.LSP.DiagnosticRelatedInformation[]
---@field public data? pasta.kit.LSP.LSPAny

---@class pasta.kit.LSP.CompletionContext
---@field public triggerKind pasta.kit.LSP.CompletionTriggerKind
---@field public triggerCharacter? string

---@class pasta.kit.LSP.CompletionItemLabelDetails
---@field public detail? string
---@field public description? string

---@class pasta.kit.LSP.InsertReplaceEdit
---@field public newText string
---@field public insert pasta.kit.LSP.Range
---@field public replace pasta.kit.LSP.Range

---@class pasta.kit.LSP.CompletionOptions
---@field public triggerCharacters? string[]
---@field public allCommitCharacters? string[]
---@field public resolveProvider? boolean
---@field public completionItem? { labelDetailsSupport?: boolean }

---@class pasta.kit.LSP.HoverOptions

---@class pasta.kit.LSP.SignatureHelpContext
---@field public triggerKind pasta.kit.LSP.SignatureHelpTriggerKind
---@field public triggerCharacter? string
---@field public isRetrigger boolean
---@field public activeSignatureHelp? pasta.kit.LSP.SignatureHelp

---@class pasta.kit.LSP.SignatureInformation
---@field public label string
---@field public documentation? (string | pasta.kit.LSP.MarkupContent)
---@field public parameters? pasta.kit.LSP.ParameterInformation[]
---@field public activeParameter? integer

---@class pasta.kit.LSP.SignatureHelpOptions
---@field public triggerCharacters? string[]
---@field public retriggerCharacters? string[]

---@class pasta.kit.LSP.DefinitionOptions

---@class pasta.kit.LSP.ReferenceContext
---@field public includeDeclaration boolean

---@class pasta.kit.LSP.ReferenceOptions

---@class pasta.kit.LSP.DocumentHighlightOptions

---@class pasta.kit.LSP.BaseSymbolInformation
---@field public name string
---@field public kind pasta.kit.LSP.SymbolKind
---@field public tags? pasta.kit.LSP.SymbolTag[]
---@field public containerName? string

---@class pasta.kit.LSP.DocumentSymbolOptions
---@field public label? string

---@class pasta.kit.LSP.CodeActionContext
---@field public diagnostics pasta.kit.LSP.Diagnostic[]
---@field public only? pasta.kit.LSP.CodeActionKind[]
---@field public triggerKind? pasta.kit.LSP.CodeActionTriggerKind

---@class pasta.kit.LSP.CodeActionOptions
---@field public codeActionKinds? pasta.kit.LSP.CodeActionKind[]
---@field public resolveProvider? boolean

---@class pasta.kit.LSP.WorkspaceSymbolOptions
---@field public resolveProvider? boolean

---@class pasta.kit.LSP.CodeLensOptions
---@field public resolveProvider? boolean

---@class pasta.kit.LSP.DocumentLinkOptions
---@field public resolveProvider? boolean

---@class pasta.kit.LSP.FormattingOptions
---@field public tabSize integer
---@field public insertSpaces boolean
---@field public trimTrailingWhitespace? boolean
---@field public insertFinalNewline? boolean
---@field public trimFinalNewlines? boolean

---@class pasta.kit.LSP.DocumentFormattingOptions

---@class pasta.kit.LSP.DocumentRangeFormattingOptions

---@class pasta.kit.LSP.DocumentOnTypeFormattingOptions
---@field public firstTriggerCharacter string
---@field public moreTriggerCharacter? string[]

---@class pasta.kit.LSP.RenameOptions
---@field public prepareProvider? boolean

---@class pasta.kit.LSP.ExecuteCommandOptions
---@field public commands string[]

---@class pasta.kit.LSP.SemanticTokensLegend
---@field public tokenTypes string[]
---@field public tokenModifiers string[]

---@class pasta.kit.LSP.OptionalVersionedTextDocumentIdentifier : pasta.kit.LSP.TextDocumentIdentifier
---@field public version (integer | nil)

---@class pasta.kit.LSP.AnnotatedTextEdit : pasta.kit.LSP.TextEdit
---@field public annotationId pasta.kit.LSP.ChangeAnnotationIdentifier

---@class pasta.kit.LSP.ResourceOperation
---@field public kind string
---@field public annotationId? pasta.kit.LSP.ChangeAnnotationIdentifier

---@class pasta.kit.LSP.CreateFileOptions
---@field public overwrite? boolean
---@field public ignoreIfExists? boolean

---@class pasta.kit.LSP.RenameFileOptions
---@field public overwrite? boolean
---@field public ignoreIfExists? boolean

---@class pasta.kit.LSP.DeleteFileOptions
---@field public recursive? boolean
---@field public ignoreIfNotExists? boolean

---@class pasta.kit.LSP.FileOperationPattern
---@field public glob string
---@field public matches? pasta.kit.LSP.FileOperationPatternKind
---@field public options? pasta.kit.LSP.FileOperationPatternOptions

---@class pasta.kit.LSP.WorkspaceFullDocumentDiagnosticReport : pasta.kit.LSP.FullDocumentDiagnosticReport
---@field public uri string
---@field public version (integer | nil)

---@class pasta.kit.LSP.WorkspaceUnchangedDocumentDiagnosticReport : pasta.kit.LSP.UnchangedDocumentDiagnosticReport
---@field public uri string
---@field public version (integer | nil)

---@class pasta.kit.LSP.LSPObject

---@class pasta.kit.LSP.NotebookCell
---@field public kind pasta.kit.LSP.NotebookCellKind
---@field public document string
---@field public metadata? pasta.kit.LSP.LSPObject
---@field public executionSummary? pasta.kit.LSP.ExecutionSummary

---@class pasta.kit.LSP.NotebookCellArrayChange
---@field public start integer
---@field public deleteCount integer
---@field public cells? pasta.kit.LSP.NotebookCell[]

---@class pasta.kit.LSP.ClientCapabilities
---@field public workspace? pasta.kit.LSP.WorkspaceClientCapabilities
---@field public textDocument? pasta.kit.LSP.TextDocumentClientCapabilities
---@field public notebookDocument? pasta.kit.LSP.NotebookDocumentClientCapabilities
---@field public window? pasta.kit.LSP.WindowClientCapabilities
---@field public general? pasta.kit.LSP.GeneralClientCapabilities
---@field public experimental? pasta.kit.LSP.LSPAny

---@class pasta.kit.LSP.TextDocumentSyncOptions
---@field public openClose? boolean
---@field public change? pasta.kit.LSP.TextDocumentSyncKind
---@field public willSave? boolean
---@field public willSaveWaitUntil? boolean
---@field public save? (boolean | pasta.kit.LSP.SaveOptions)

---@class pasta.kit.LSP.NotebookDocumentSyncOptions
---@field public notebookSelector ({ notebook: (string | pasta.kit.LSP.NotebookDocumentFilter), cells?: { language: string }[] } | { notebook?: (string | pasta.kit.LSP.NotebookDocumentFilter), cells: { language: string }[] })[]
---@field public save? boolean

---@class pasta.kit.LSP.NotebookDocumentSyncRegistrationOptions : pasta.kit.LSP.NotebookDocumentSyncOptions

---@class pasta.kit.LSP.WorkspaceFoldersServerCapabilities
---@field public supported? boolean
---@field public changeNotifications? (string | boolean)

---@class pasta.kit.LSP.FileOperationOptions
---@field public didCreate? pasta.kit.LSP.FileOperationRegistrationOptions
---@field public willCreate? pasta.kit.LSP.FileOperationRegistrationOptions
---@field public didRename? pasta.kit.LSP.FileOperationRegistrationOptions
---@field public willRename? pasta.kit.LSP.FileOperationRegistrationOptions
---@field public didDelete? pasta.kit.LSP.FileOperationRegistrationOptions
---@field public willDelete? pasta.kit.LSP.FileOperationRegistrationOptions

---@class pasta.kit.LSP.CodeDescription
---@field public href string

---@class pasta.kit.LSP.DiagnosticRelatedInformation
---@field public location pasta.kit.LSP.Location
---@field public message string

---@class pasta.kit.LSP.ParameterInformation
---@field public label (string | (integer | integer)[])
---@field public documentation? (string | pasta.kit.LSP.MarkupContent)

---@class pasta.kit.LSP.NotebookCellTextDocumentFilter
---@field public notebook (string | pasta.kit.LSP.NotebookDocumentFilter)
---@field public language? string

---@class pasta.kit.LSP.FileOperationPatternOptions
---@field public ignoreCase? boolean

---@class pasta.kit.LSP.ExecutionSummary
---@field public executionOrder integer
---@field public success? boolean

---@class pasta.kit.LSP.WorkspaceClientCapabilities
---@field public applyEdit? boolean
---@field public workspaceEdit? pasta.kit.LSP.WorkspaceEditClientCapabilities
---@field public didChangeConfiguration? pasta.kit.LSP.DidChangeConfigurationClientCapabilities
---@field public didChangeWatchedFiles? pasta.kit.LSP.DidChangeWatchedFilesClientCapabilities
---@field public symbol? pasta.kit.LSP.WorkspaceSymbolClientCapabilities
---@field public executeCommand? pasta.kit.LSP.ExecuteCommandClientCapabilities
---@field public workspaceFolders? boolean
---@field public configuration? boolean
---@field public semanticTokens? pasta.kit.LSP.SemanticTokensWorkspaceClientCapabilities
---@field public codeLens? pasta.kit.LSP.CodeLensWorkspaceClientCapabilities
---@field public fileOperations? pasta.kit.LSP.FileOperationClientCapabilities
---@field public inlineValue? pasta.kit.LSP.InlineValueWorkspaceClientCapabilities
---@field public inlayHint? pasta.kit.LSP.InlayHintWorkspaceClientCapabilities
---@field public diagnostics? pasta.kit.LSP.DiagnosticWorkspaceClientCapabilities

---@class pasta.kit.LSP.TextDocumentClientCapabilities
---@field public synchronization? pasta.kit.LSP.TextDocumentSyncClientCapabilities
---@field public completion? pasta.kit.LSP.CompletionClientCapabilities
---@field public hover? pasta.kit.LSP.HoverClientCapabilities
---@field public signatureHelp? pasta.kit.LSP.SignatureHelpClientCapabilities
---@field public declaration? pasta.kit.LSP.DeclarationClientCapabilities
---@field public definition? pasta.kit.LSP.DefinitionClientCapabilities
---@field public typeDefinition? pasta.kit.LSP.TypeDefinitionClientCapabilities
---@field public implementation? pasta.kit.LSP.ImplementationClientCapabilities
---@field public references? pasta.kit.LSP.ReferenceClientCapabilities
---@field public documentHighlight? pasta.kit.LSP.DocumentHighlightClientCapabilities
---@field public documentSymbol? pasta.kit.LSP.DocumentSymbolClientCapabilities
---@field public codeAction? pasta.kit.LSP.CodeActionClientCapabilities
---@field public codeLens? pasta.kit.LSP.CodeLensClientCapabilities
---@field public documentLink? pasta.kit.LSP.DocumentLinkClientCapabilities
---@field public colorProvider? pasta.kit.LSP.DocumentColorClientCapabilities
---@field public formatting? pasta.kit.LSP.DocumentFormattingClientCapabilities
---@field public rangeFormatting? pasta.kit.LSP.DocumentRangeFormattingClientCapabilities
---@field public onTypeFormatting? pasta.kit.LSP.DocumentOnTypeFormattingClientCapabilities
---@field public rename? pasta.kit.LSP.RenameClientCapabilities
---@field public foldingRange? pasta.kit.LSP.FoldingRangeClientCapabilities
---@field public selectionRange? pasta.kit.LSP.SelectionRangeClientCapabilities
---@field public publishDiagnostics? pasta.kit.LSP.PublishDiagnosticsClientCapabilities
---@field public callHierarchy? pasta.kit.LSP.CallHierarchyClientCapabilities
---@field public semanticTokens? pasta.kit.LSP.SemanticTokensClientCapabilities
---@field public linkedEditingRange? pasta.kit.LSP.LinkedEditingRangeClientCapabilities
---@field public moniker? pasta.kit.LSP.MonikerClientCapabilities
---@field public typeHierarchy? pasta.kit.LSP.TypeHierarchyClientCapabilities
---@field public inlineValue? pasta.kit.LSP.InlineValueClientCapabilities
---@field public inlayHint? pasta.kit.LSP.InlayHintClientCapabilities
---@field public diagnostic? pasta.kit.LSP.DiagnosticClientCapabilities

---@class pasta.kit.LSP.NotebookDocumentClientCapabilities
---@field public synchronization pasta.kit.LSP.NotebookDocumentSyncClientCapabilities

---@class pasta.kit.LSP.WindowClientCapabilities
---@field public workDoneProgress? boolean
---@field public showMessage? pasta.kit.LSP.ShowMessageRequestClientCapabilities
---@field public showDocument? pasta.kit.LSP.ShowDocumentClientCapabilities

---@class pasta.kit.LSP.GeneralClientCapabilities
---@field public staleRequestSupport? { cancel: boolean, retryOnContentModified: string[] }
---@field public regularExpressions? pasta.kit.LSP.RegularExpressionsClientCapabilities
---@field public markdown? pasta.kit.LSP.MarkdownClientCapabilities
---@field public positionEncodings? pasta.kit.LSP.PositionEncodingKind[]

---@class pasta.kit.LSP.RelativePattern
---@field public baseUri (pasta.kit.LSP.WorkspaceFolder | string)
---@field public pattern pasta.kit.LSP.Pattern

---@class pasta.kit.LSP.WorkspaceEditClientCapabilities
---@field public documentChanges? boolean
---@field public resourceOperations? pasta.kit.LSP.ResourceOperationKind[]
---@field public failureHandling? pasta.kit.LSP.FailureHandlingKind
---@field public normalizesLineEndings? boolean
---@field public changeAnnotationSupport? { groupsOnLabel?: boolean }

---@class pasta.kit.LSP.DidChangeConfigurationClientCapabilities
---@field public dynamicRegistration? boolean

---@class pasta.kit.LSP.DidChangeWatchedFilesClientCapabilities
---@field public dynamicRegistration? boolean
---@field public relativePatternSupport? boolean

---@class pasta.kit.LSP.WorkspaceSymbolClientCapabilities
---@field public dynamicRegistration? boolean
---@field public symbolKind? { valueSet?: pasta.kit.LSP.SymbolKind[] }
---@field public tagSupport? { valueSet: pasta.kit.LSP.SymbolTag[] }
---@field public resolveSupport? { properties: string[] }

---@class pasta.kit.LSP.ExecuteCommandClientCapabilities
---@field public dynamicRegistration? boolean

---@class pasta.kit.LSP.SemanticTokensWorkspaceClientCapabilities
---@field public refreshSupport? boolean

---@class pasta.kit.LSP.CodeLensWorkspaceClientCapabilities
---@field public refreshSupport? boolean

---@class pasta.kit.LSP.FileOperationClientCapabilities
---@field public dynamicRegistration? boolean
---@field public didCreate? boolean
---@field public willCreate? boolean
---@field public didRename? boolean
---@field public willRename? boolean
---@field public didDelete? boolean
---@field public willDelete? boolean

---@class pasta.kit.LSP.InlineValueWorkspaceClientCapabilities
---@field public refreshSupport? boolean

---@class pasta.kit.LSP.InlayHintWorkspaceClientCapabilities
---@field public refreshSupport? boolean

---@class pasta.kit.LSP.DiagnosticWorkspaceClientCapabilities
---@field public refreshSupport? boolean

---@class pasta.kit.LSP.TextDocumentSyncClientCapabilities
---@field public dynamicRegistration? boolean
---@field public willSave? boolean
---@field public willSaveWaitUntil? boolean
---@field public didSave? boolean

---@class pasta.kit.LSP.CompletionClientCapabilities
---@field public dynamicRegistration? boolean
---@field public completionItem? { snippetSupport?: boolean, commitCharactersSupport?: boolean, documentationFormat?: pasta.kit.LSP.MarkupKind[], deprecatedSupport?: boolean, preselectSupport?: boolean, tagSupport?: { valueSet: pasta.kit.LSP.CompletionItemTag[] }, insertReplaceSupport?: boolean, resolveSupport?: { properties: string[] }, insertTextModeSupport?: { valueSet: pasta.kit.LSP.InsertTextMode[] }, labelDetailsSupport?: boolean }
---@field public completionItemKind? { valueSet?: pasta.kit.LSP.CompletionItemKind[] }
---@field public insertTextMode? pasta.kit.LSP.InsertTextMode
---@field public contextSupport? boolean
---@field public completionList? { itemDefaults?: string[] }

---@class pasta.kit.LSP.HoverClientCapabilities
---@field public dynamicRegistration? boolean
---@field public contentFormat? pasta.kit.LSP.MarkupKind[]

---@class pasta.kit.LSP.SignatureHelpClientCapabilities
---@field public dynamicRegistration? boolean
---@field public signatureInformation? { documentationFormat?: pasta.kit.LSP.MarkupKind[], parameterInformation?: { labelOffsetSupport?: boolean }, activeParameterSupport?: boolean }
---@field public contextSupport? boolean

---@class pasta.kit.LSP.DeclarationClientCapabilities
---@field public dynamicRegistration? boolean
---@field public linkSupport? boolean

---@class pasta.kit.LSP.DefinitionClientCapabilities
---@field public dynamicRegistration? boolean
---@field public linkSupport? boolean

---@class pasta.kit.LSP.TypeDefinitionClientCapabilities
---@field public dynamicRegistration? boolean
---@field public linkSupport? boolean

---@class pasta.kit.LSP.ImplementationClientCapabilities
---@field public dynamicRegistration? boolean
---@field public linkSupport? boolean

---@class pasta.kit.LSP.ReferenceClientCapabilities
---@field public dynamicRegistration? boolean

---@class pasta.kit.LSP.DocumentHighlightClientCapabilities
---@field public dynamicRegistration? boolean

---@class pasta.kit.LSP.DocumentSymbolClientCapabilities
---@field public dynamicRegistration? boolean
---@field public symbolKind? { valueSet?: pasta.kit.LSP.SymbolKind[] }
---@field public hierarchicalDocumentSymbolSupport? boolean
---@field public tagSupport? { valueSet: pasta.kit.LSP.SymbolTag[] }
---@field public labelSupport? boolean

---@class pasta.kit.LSP.CodeActionClientCapabilities
---@field public dynamicRegistration? boolean
---@field public codeActionLiteralSupport? { codeActionKind: { valueSet: pasta.kit.LSP.CodeActionKind[] } }
---@field public isPreferredSupport? boolean
---@field public disabledSupport? boolean
---@field public dataSupport? boolean
---@field public resolveSupport? { properties: string[] }
---@field public honorsChangeAnnotations? boolean

---@class pasta.kit.LSP.CodeLensClientCapabilities
---@field public dynamicRegistration? boolean

---@class pasta.kit.LSP.DocumentLinkClientCapabilities
---@field public dynamicRegistration? boolean
---@field public tooltipSupport? boolean

---@class pasta.kit.LSP.DocumentColorClientCapabilities
---@field public dynamicRegistration? boolean

---@class pasta.kit.LSP.DocumentFormattingClientCapabilities
---@field public dynamicRegistration? boolean

---@class pasta.kit.LSP.DocumentRangeFormattingClientCapabilities
---@field public dynamicRegistration? boolean

---@class pasta.kit.LSP.DocumentOnTypeFormattingClientCapabilities
---@field public dynamicRegistration? boolean

---@class pasta.kit.LSP.RenameClientCapabilities
---@field public dynamicRegistration? boolean
---@field public prepareSupport? boolean
---@field public prepareSupportDefaultBehavior? pasta.kit.LSP.PrepareSupportDefaultBehavior
---@field public honorsChangeAnnotations? boolean

---@class pasta.kit.LSP.FoldingRangeClientCapabilities
---@field public dynamicRegistration? boolean
---@field public rangeLimit? integer
---@field public lineFoldingOnly? boolean
---@field public foldingRangeKind? { valueSet?: pasta.kit.LSP.FoldingRangeKind[] }
---@field public foldingRange? { collapsedText?: boolean }

---@class pasta.kit.LSP.SelectionRangeClientCapabilities
---@field public dynamicRegistration? boolean

---@class pasta.kit.LSP.PublishDiagnosticsClientCapabilities
---@field public relatedInformation? boolean
---@field public tagSupport? { valueSet: pasta.kit.LSP.DiagnosticTag[] }
---@field public versionSupport? boolean
---@field public codeDescriptionSupport? boolean
---@field public dataSupport? boolean

---@class pasta.kit.LSP.CallHierarchyClientCapabilities
---@field public dynamicRegistration? boolean

---@class pasta.kit.LSP.SemanticTokensClientCapabilities
---@field public dynamicRegistration? boolean
---@field public requests { range?: (boolean | {  }), full?: (boolean | { delta?: boolean }) }
---@field public tokenTypes string[]
---@field public tokenModifiers string[]
---@field public formats pasta.kit.LSP.TokenFormat[]
---@field public overlappingTokenSupport? boolean
---@field public multilineTokenSupport? boolean
---@field public serverCancelSupport? boolean
---@field public augmentsSyntaxTokens? boolean

---@class pasta.kit.LSP.LinkedEditingRangeClientCapabilities
---@field public dynamicRegistration? boolean

---@class pasta.kit.LSP.MonikerClientCapabilities
---@field public dynamicRegistration? boolean

---@class pasta.kit.LSP.TypeHierarchyClientCapabilities
---@field public dynamicRegistration? boolean

---@class pasta.kit.LSP.InlineValueClientCapabilities
---@field public dynamicRegistration? boolean

---@class pasta.kit.LSP.InlayHintClientCapabilities
---@field public dynamicRegistration? boolean
---@field public resolveSupport? { properties: string[] }

---@class pasta.kit.LSP.DiagnosticClientCapabilities
---@field public dynamicRegistration? boolean
---@field public relatedDocumentSupport? boolean

---@class pasta.kit.LSP.NotebookDocumentSyncClientCapabilities
---@field public dynamicRegistration? boolean
---@field public executionSummarySupport? boolean

---@class pasta.kit.LSP.ShowMessageRequestClientCapabilities
---@field public messageActionItem? { additionalPropertiesSupport?: boolean }

---@class pasta.kit.LSP.ShowDocumentClientCapabilities
---@field public support boolean

---@class pasta.kit.LSP.RegularExpressionsClientCapabilities
---@field public engine string
---@field public version? string

---@class pasta.kit.LSP.MarkdownClientCapabilities
---@field public parser string
---@field public version? string
---@field public allowedTags? string[]

---@alias pasta.kit.LSP.Definition (pasta.kit.LSP.Location | pasta.kit.LSP.Location[])

---@alias pasta.kit.LSP.DefinitionLink pasta.kit.LSP.LocationLink

---@alias pasta.kit.LSP.LSPArray pasta.kit.LSP.LSPAny[]

---@alias pasta.kit.LSP.LSPAny (pasta.kit.LSP.LSPObject | pasta.kit.LSP.LSPArray | string | integer | integer | integer | boolean | nil)

---@alias pasta.kit.LSP.Declaration (pasta.kit.LSP.Location | pasta.kit.LSP.Location[])

---@alias pasta.kit.LSP.DeclarationLink pasta.kit.LSP.LocationLink

---@alias pasta.kit.LSP.InlineValue (pasta.kit.LSP.InlineValueText | pasta.kit.LSP.InlineValueVariableLookup | pasta.kit.LSP.InlineValueEvaluatableExpression)

---@alias pasta.kit.LSP.DocumentDiagnosticReport (pasta.kit.LSP.RelatedFullDocumentDiagnosticReport | pasta.kit.LSP.RelatedUnchangedDocumentDiagnosticReport)

---@alias pasta.kit.LSP.PrepareRenameResult (pasta.kit.LSP.Range | { range: pasta.kit.LSP.Range, placeholder: string } | { defaultBehavior: boolean })

---@alias pasta.kit.LSP.ProgressToken (integer | string)

---@alias pasta.kit.LSP.DocumentSelector pasta.kit.LSP.DocumentFilter[]

---@alias pasta.kit.LSP.ChangeAnnotationIdentifier string

---@alias pasta.kit.LSP.WorkspaceDocumentDiagnosticReport (pasta.kit.LSP.WorkspaceFullDocumentDiagnosticReport | pasta.kit.LSP.WorkspaceUnchangedDocumentDiagnosticReport)

---@alias pasta.kit.LSP.TextDocumentContentChangeEvent ({ range: pasta.kit.LSP.Range, rangeLength?: integer, text: string } | { text: string })

---@alias pasta.kit.LSP.MarkedString (string | { language: string, value: string })

---@alias pasta.kit.LSP.DocumentFilter (pasta.kit.LSP.TextDocumentFilter | pasta.kit.LSP.NotebookCellTextDocumentFilter)

---@alias pasta.kit.LSP.GlobPattern (pasta.kit.LSP.Pattern | pasta.kit.LSP.RelativePattern)

---@alias pasta.kit.LSP.TextDocumentFilter ({ language: string, scheme?: string, pattern?: string } | { language?: string, scheme: string, pattern?: string } | { language?: string, scheme?: string, pattern: string })

---@alias pasta.kit.LSP.NotebookDocumentFilter ({ notebookType: string, scheme?: string, pattern?: string } | { notebookType?: string, scheme: string, pattern?: string } | { notebookType?: string, scheme?: string, pattern: string })

---@alias pasta.kit.LSP.Pattern string

return LSP
