//
//  Created BY 2U on 2021/6/31
//  B.Y QQ2222123779  
//  仅供学习交流
//  星火

#pragma mark - 调用文件
#import "Drawst.h"
#import "Drawzb.h"
#import "Drawlm.h"
#import "Drawdk.h"
#import "JFPlayerPool.h"
#import "JFPropsPool.h"
#import "JFCommon.h"
#import "Color.h"
#include <JRMemory/MemScan.h>

#import "imgui.h"
#import "imgui_internal.h"
#import "ImGuiWrapper.h"
#import "ImGuiStyleWrapper.h"
#import "TextEditorWrapper.h"
#import "GuiRenderer.h"

#define STB_IMAGE_IMPLEMENTATION
#define IOSW [UIScreen mainScreen].bounds.size.width
#define IOSH [UIScreen mainScreen].bounds.size.height

//#import "baidu_font.h"
#define iPhone8P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
using namespace std;
std::string string_format(const std::string &fmt, ...) {
    std::vector<char> str(100,'\0');
    va_list ap;
    while (1) {
        va_start(ap, fmt);
        auto n = vsnprintf(str.data(), str.size(), fmt.c_str(), ap);
        va_end(ap);
        if ((n > -1) && (size_t(n) < str.size())) {
            return str.data();
        }
        if (n > -1)
            str.resize( n + 1 );
        else
            str.resize( str.size() * 2);
    }
    return str.data();
}







@interface TencentAntiView () <GuiRendererDelegate> {
    ImFont *_espFont;
    ImFont *_espFont2;
    ImTextureID * _espimge;
}

@property (nonatomic, strong) MTKView *mtkView;
@property (nonatomic, strong) GuiRenderer *renderer;
@property long flyz;
@property long baseAdr2;
@end

@implementation TencentAntiView
static int julix = 0;
static int juliy = 0;
static int julisize = 13;
static BOOL aiint = false;
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        
        self.isStartTimer = false;
        self.isShowMenu = false;
        self.isLineEsp = false;
        self.isBoxEsp = false;
        self.isBoneEsp = false;
        self.isHpBarEsp = false;
        self.isTextEsp = false;
        self.isTextEspmi = false;
        self.isAimbot = false;
        self.isGunAimbot = false;
        self.isNorecoil = false;
        self.isspped = false;
        self.isNearDeathNotAim = false;
        self.isShowProps = false;
        self.isShowPropsVehicle = false;
        self.isShowPropsWeapon = false;
        self.isShowPropsArmor = false;
        self.isShowPropsSight = false;
        self.isShowPropsEarlyWarning = false;
        self.BPc = false;
        self.BoxWith = false;
        self.Pistol = false;
        self.isTeamMateEsp = false;
        self.isBulletTrack = false;
        
        self.propsDistance = 300;
        self.aimbotPart = 6;
        self.aimbotRadius = 100;
        self.espDistance = 300;
        self.doubleGun = 0.01;
        self.autoAim = 0;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.mtkView = [[MTKView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.mtkView.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self.mtkView];
    self.mtkView.device = MTLCreateSystemDefaultDevice();
    if (!self.mtkView.device) {
        return;
    }
    
    self.renderer = [[GuiRenderer alloc] initWithView:self.mtkView];
    self.renderer.delegate = self;
    self.mtkView.delegate = self.renderer;
    [self.renderer initializePlatform];
}


#pragma mark - GuiRendererDelegate
- (void)setup
{
    ImGuiIO & io = ImGui::GetIO();
    //ImFontConfig config;
    //config.FontDataOwnedByAtlas = true;

    NSString *FontPath = @"/System/Library/Fonts/LanguageSupport/PingFang.ttc";
    _espFont = io.Fonts->AddFontFromFileTTF(FontPath.UTF8String, 20.f,NULL,io.Fonts->GetGlyphRangesChineseFull());
    
    _espFont2 = io.Fonts->AddFontFromFileTTF(FontPath.UTF8String, 40.f,NULL,io.Fonts->GetGlyphRangesChineseFull());
    
}

- (void)draw
{
    [self drawOverlay];
    [self drawMenu];
}

#pragma mark - 绘制
//绘制菜单
- (void)drawMenu
{
    self.userInteractionEnabled = self.isShowMenu;
    self.mtkView.userInteractionEnabled = self.isShowMenu;
    if (!_isShowMenu) {
        return;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        CGFloat width = SCREEN_WIDTH * 0.80;
        CGFloat height = SCREEN_HEIGHT * 0.80;
        
     
        //主题设置
        ImGuiStyle& style = ImGui::GetStyle();
        style.FrameRounding = 4;
        style.WindowBorderSize = 1;
        style.FramePadding = ImVec2(0.0f,2.0f);
        style.ItemSpacing = ImVec2(20.0f,5.0f);
        style.ItemInnerSpacing = ImVec2(4.0f,4.0f);
        style.IndentSpacing = 30;
        style.ScrollbarSize = 25;
        style.GrabMinSize = 12;
        style.WindowBorderSize = 1.3;
        style.ChildBorderSize = 1;
        style.PopupBorderSize = 1;
        style.WindowRounding = 7;
        style.ChildRounding = 23;
        style.ChildRounding = 12;
        style.FrameRounding = 3;
        style.PopupRounding = 12;
        style.GrabRounding = 3;
        style.ScrollbarRounding = 12;
        
        
        style.Colors[0] = ImVec4(0.000f,0.000f,0.000f,1.000f);
        style.Colors[2] = ImVec4(0.933f,0.933f,0.933f,0.980f);
        style.Colors[11] = ImVec4(0.933f,0.933f,0.933f,0.980f);
        style.Colors[12] = ImVec4(0.933f,0.933f,0.933f,0.980f);
        style.Colors[18] = ImVec4(1.000f,0.784f,0.512f,1.000f);
        style.Colors[24] = ImVec4(0.933f,0.933f,0.933f,0.980f);
        style.Colors[25] = ImVec4(0.933f,0.933f,0.933f,0.980f);
        style.Colors[26] = ImVec4(0.933f,0.933f,0.933f,0.980f);
        //&style.AntiAliasedFill = false;
        ImGuiIO & io = ImGui::GetIO();
        
        io.DisplaySize = ImVec2(width, height);
        
        ImGui::SetNextWindowPos(ImVec2((SCREEN_WIDTH ) * 0.1, (SCREEN_HEIGHT ) * 0.1), 0, ImVec2(0, 0));
        ImGui::SetNextWindowSize(ImVec2(io.DisplaySize.x, io.DisplaySize.y));
      
    });
    
    ImGui::Begin("a", &_isShowMenu, ImGuiWindowFlags_NoMove |
                               ImGuiWindowFlags_NoTitleBar |
                               ImGuiWindowFlags_NoCollapse |
                                ImGuiWindowFlags_NoResize );
    ImGui::Text("TopHPJY-www.qmui.club");
    
    ImGuiStyle& style = ImGui::GetStyle();
    style.FramePadding = ImVec2(0.0f,2.0f);

if (ImGui::CollapsingHeader("一般设定"))
{
    ImGuiStyle& style = ImGui::GetStyle();
    style.FramePadding = ImVec2(20.0f,5.0f);
 style.Colors[0] = ImVec4(1.000f,1.000f,1.000f,1.000f);
 
  
    
{
    ImGuiStyle& style = ImGui::GetStyle();
    style.ItemSpacing = ImVec2(20.0f,5.0f);
    style.FramePadding = ImVec2(20.0f,5.0f);
ImGui::PushID(1);
ImGui::PushStyleColor(ImGuiCol_Button, (ImVec4)ImColor::HSV(3 / 7.0f, 0.6f, 0.6f));
ImGui::PushStyleColor(ImGuiCol_ButtonHovered, (ImVec4)ImColor::HSV(3 / 7.0f, 0.7f, 0.7f));
ImGui::PushStyleColor(ImGuiCol_ButtonActive, (ImVec4)ImColor::HSV(3 / 7.0f, 0.8f, 0.8f));
if(ImGui::Button("大厅范围")){
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x160000000};
        SInt64 search = 4756927107519479808;
        engine.JRScanMemory(range, &search, JR_Search_Type_SLong);
        vector<void*>results = engine.getAllResults();
        SInt64 modify = 4756927107639234560;
        for(int i = 0; i < results.size(); i++){
            engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SLong);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:nil message:@"开启成功" preferredStyle:UIAlertControllerStyleAlert];
        
        [[[[UIApplication sharedApplication] windows] objectAtIndex:0].rootViewController presentViewController:alert1 animated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [alert1 dismissViewControllerAnimated:YES completion:nil];
            
    });
        });
    });
    
}
ImGui::PopStyleColor(3);
ImGui::PopID();
}
ImGui::SameLine();
{
{
    ImGuiStyle& style = ImGui::GetStyle();
    style.ItemSpacing = ImVec2(290.0f,5.0f);
  ImGui::PushID(2);
  ImGui::PushStyleColor(ImGuiCol_Button, (ImVec4)ImColor::HSV(3 / 7.0f, 0.6f, 0.6f));
  ImGui::PushStyleColor(ImGuiCol_ButtonHovered, (ImVec4)ImColor::HSV(3 / 7.0f, 0.7f, 0.7f));
  ImGui::PushStyleColor(ImGuiCol_ButtonActive, (ImVec4)ImColor::HSV(3 / 7.0f, 0.8f, 0.8f));
  if(ImGui::Button("出生岛范围")){
      dispatch_async(dispatch_get_global_queue(0, 0), ^{
          
          JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
          AddrRange range = (AddrRange){0x100000000,0x160000000};
          SInt32 search = 67109633;
          engine.JRScanMemory(range, &search, JR_Search_Type_SInt);
          SInt32 search1 = 134914;
          engine.JRNearBySearch(0x100, &search1, JR_Search_Type_SInt);
          engine.JRScanMemory(range, &search, JR_Search_Type_SInt);
          vector<void*>results = engine.getAllResults();
          SInt32 modify = 0;
          for(int i = 0; i < results.size(); i++){
              engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SInt);
          }
          
          dispatch_async(dispatch_get_main_queue(), ^{
          UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:nil message:@"开启成功" preferredStyle:UIAlertControllerStyleAlert];
          
          [[[[UIApplication sharedApplication] windows] objectAtIndex:0].rootViewController presentViewController:alert1 animated:YES completion:nil];
          
          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              
              [alert1 dismissViewControllerAnimated:YES completion:nil];
              
      });
          });
      });
   }
  ImGui::PopStyleColor(3);
  ImGui::PopID();
}
ImGui::SameLine();
{
    ImGuiStyle& style = ImGui::GetStyle();
    style.ItemSpacing = ImVec2(20.0f,5.0f);
  ImGui::PushID(3);
  ImGui::PushStyleColor(ImGuiCol_Button, (ImVec4)ImColor::HSV(7 / 7.0f, 0.6f, 0.6f));
  ImGui::PushStyleColor(ImGuiCol_ButtonHovered, (ImVec4)ImColor::HSV(7 / 7.0f, 0.7f, 0.7f));
  ImGui::PushStyleColor(ImGuiCol_ButtonActive, (ImVec4)ImColor::HSV(7 / 7.0f, 0.8f, 0.8f));
  if(ImGui::Button("退出游戏")){
      exit(-1);
   }
  ImGui::PopStyleColor(3);
  ImGui::PopID();
}
}
ImGui::SameLine();
{
    ImGuiStyle& style = ImGui::GetStyle();
    style.ItemSpacing = ImVec2(20.0f,5.0f);
    
ImGui::PushID(4);
ImGui::PushStyleColor(ImGuiCol_Button, (ImVec4)ImColor::HSV(3 / 7.0f, 0.6f, 0.6f));
ImGui::PushStyleColor(ImGuiCol_ButtonHovered, (ImVec4)ImColor::HSV(3 / 7.0f, 0.7f, 0.7f));
ImGui::PushStyleColor(ImGuiCol_ButtonActive, (ImVec4)ImColor::HSV(3 / 7.0f, 0.8f, 0.8f));
if(ImGui::Button(" ")){
}
ImGui::PopStyleColor(3);
ImGui::PopID();
}
    {
        ImGuiStyle& style = ImGui::GetStyle();
        style.Colors[0] = ImVec4(0.000f,0.000f,0.000f,1.000f);
    }
{
ImGuiStyle& style = ImGui::GetStyle();
style.ItemSpacing = ImVec2(290.0f,5.0f);
style.FramePadding = ImVec2(0.0f,2.0f);
ImGui::Checkbox("开启透视", &_isStartTimer);
ImGui::SameLine();
ImGui::Checkbox("玩家信息", &_isTextEsp);
ImGui::Checkbox("玩家骨骼", &_isBoneEsp);
ImGui::SameLine();
ImGui::Checkbox("玩家射线", &_isLineEsp);
    
ImGui::Checkbox("Anti-aliased优化图形", &style.AntiAliasedFill);
ImGui::Checkbox("Anti-AliasedLines抗锯齿", &style.AntiAliasedLines);
    
}
    {
    ImGuiStyle& style = ImGui::GetStyle();
    style.ItemSpacing = ImVec2(20.0f,5.0f);
    ImGui::Separator();
    ImGui::Text("登陆状态:");
 //   ImGui::SameLine();
  //  NSString *ciangeuha = [[NSUserDefaults standardUserDefaults] objectForKey:@"ShowTime"];
  //  ImGui::TextColored(ImVec4(1.0f, 0.4f, 0.4f, 1.0f), "过期于:\n%s",ciangeuha);
    ImGui::Separator();

    }
}

if (ImGui::CollapsingHeader("自瞄跟踪"))
{
ImGuiStyle& style = ImGui::GetStyle();
style.ItemSpacing = ImVec2(290.0f,5.0f);

ImGui::Separator();
ImGui::Checkbox("自瞄开关", &_isAimbot);
ImGui::SameLine();
ImGui::Checkbox("不瞄倒地", &_isNearDeathNotAim);
ImGui::RadioButton("锁定头部", &_aimbotPart, 6); ImGui::SameLine();
ImGui::RadioButton("锁定脖部", &_aimbotPart, 3); ImGui::SameLine();
ImGui::RadioButton("锁定屁部", &_aimbotPart, 2);
ImGui::Checkbox("子弹加速", &_isspped);
ImGui::SameLine();
ImGui::Checkbox("开镜自瞄", &_isGunAimbot);
ImGui::Checkbox("开镜无后", &_isNorecoil);
ImGui::SameLine();
//ImGui::Checkbox("子弹跟踪", &_isBulletTrack);
    ImGui::Checkbox("自动调整", &aiint);
ImGui::SliderInt("自瞄范围", &_aimbotRadius, 1, 300);
ImGui::Separator();
ImGui::Text("自瞄模式");
static int eu = 0;
  ImGui::RadioButton("准星模式", &eu, 0); ImGui::SameLine();
  ImGui::RadioButton("距离模式", &eu, 1);
ImGui::Separator();
    {
    ImGuiStyle& style = ImGui::GetStyle();
    style.FramePadding = ImVec2(20.0f,5.0f);
ImGui::Button("设置自瞄起始位置");
    }
}

if (ImGui::CollapsingHeader("装备"))
{
    ImGuiStyle& style = ImGui::GetStyle();
    style.ItemSpacing = ImVec2(290.0f,5.0f);
    style.FramePadding = ImVec2(0.0f,2.0f);
    ImGui::Checkbox("消音枪口", &_isShowProps);
    ImGui::SameLine();
    ImGui::Checkbox("M4A1", &_isShowProps );
    ImGui::Checkbox("补偿枪口", &_isShowPropsVehicle);
    ImGui::SameLine();
    ImGui::Checkbox("AKM", &_isShowProps);
    ImGui::Checkbox("消焰枪口", &_isShowPropsWeapon);
    ImGui::SameLine();
    ImGui::Checkbox("M16", &_isShowProps);
    ImGui::Checkbox("快速弹夹", &_isShowPropsArmor);
    ImGui::SameLine();
    ImGui::Checkbox("SCAR", &_isShowProps);
    ImGui::Checkbox("扩容弹夹", &_isShowPropsSight);
    ImGui::SameLine();
    ImGui::Checkbox("GROZA", &_isShowProps);
    ImGui::Checkbox("快扩弹夹", &_isShowPropsAccessory);
    ImGui::SameLine();
    ImGui::Checkbox("AUG", &_isShowProps);
    ImGui::Checkbox("垂直握把", &_isShowPropsBullet);
    ImGui::SameLine();
    ImGui::Checkbox("QBZ", &_isShowProps);
    ImGui::Checkbox("轻型握把", &_isShowPropsDrug);
    ImGui::SameLine();
    ImGui::Checkbox("M762", &_isShowProps);
    ImGui::Checkbox("三角握把", &_isShowPropsEarlyWarning);
    ImGui::SameLine();
    ImGui::Checkbox("G36C", &_isShowProps);
    ImGui::Checkbox("战术枪托", &_BoxWith);
    ImGui::SameLine();
    ImGui::Checkbox("UMP45", &_isShowProps);
    ImGui::Checkbox("一级包", &_BPc);
    ImGui::SameLine();
    ImGui::Checkbox("二级包", &_Pistol);
    ImGui::SameLine();
    ImGui::Checkbox("三级包", &_isShowProps);
    ImGui::Checkbox("一级头", &_isShowProps);
    ImGui::SameLine();
    ImGui::Checkbox("二级头", &_isShowProps);
    ImGui::SameLine();
    ImGui::Checkbox("三级头", &_isShowProps);
}

if (ImGui::CollapsingHeader("医疗"))
{
    ImGuiStyle& style = ImGui::GetStyle();
    style.ItemSpacing = ImVec2(290.0f,5.0f);
    ImGui::Checkbox("医疗箱", &_isShowProps);
    ImGui::SameLine();
    ImGui::Checkbox("肾上腺素", &_isShowProps);
    ImGui::Checkbox("医疗包", &_isShowProps);
    ImGui::SameLine();
    ImGui::Checkbox("能量饮料", &_isShowProps);
    ImGui::Checkbox("止疼药", &_isShowProps);
    ImGui::SameLine();
    ImGui::Checkbox("绷带", &_isShowProps);
}

if (ImGui::CollapsingHeader("载具"))
{
    ImGuiStyle& style = ImGui::GetStyle();
    style.ItemSpacing = ImVec2(290.0f,5.0f);
    ImGui::Checkbox("吉普", &_isShowProps);
    ImGui::SameLine();
    ImGui::Checkbox("轿车", &_isShowProps);
    ImGui::Checkbox("蹦蹦", &_isShowProps);
    ImGui::SameLine();
    ImGui::Checkbox("三轮", &_isShowProps);
    ImGui::Checkbox("摩托", &_isShowProps);
    ImGui::SameLine();
    ImGui::Checkbox("飞机", &_isShowProps);
}

if (ImGui::CollapsingHeader("调整"))
{
    ImGuiStyle& style = ImGui::GetStyle();
    style.ItemSpacing = ImVec2(20.0f,5.0f);

    ImGui::SliderInt("设置缩放", &_aimbotRadius, 50, 100);

    ImGui::SliderInt("距离x调整", &julix, -50, 50);

    ImGui::SliderInt("距离y调整", &juliy, -50, 50);

    ImGui::SliderInt("距离字体调整", &julisize, 10, 50);
}
    
    
 //   ImGuiIO & io = ImGui::GetIO();
 //   NSString *fontPath2 = @"/123.png";
 //   ImTextureID my_tex_id = fontPath2;
 //   float my_tex_w = (float)io.Fonts->TexWidth;
 //   float my_tex_h = (float)io.Fonts->TexHeight;
 //   ImGui::Image(my_tex_id, ImVec2(my_tex_w, my_tex_h), uv_min, uv_max, tint_col, border_col);
 //   ImVec2 pos = ImGui::GetCursorScreenPos();
 //   ImVec2 uv_min = ImVec2(0.0f, 0.0f);                 // Top-left
 //   ImVec2 uv_max = ImVec2(1.0f, 1.0f);                 // Lower-right
 //   ImVec4 tint_col = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);   // No tint
 //   ImVec4 border_col = ImVec4(1.0f, 1.0f, 1.0f, 0.5f); // 50% opaque white
 //

ImGui::Separator();
  
   // ImGui::ShowDemoWindow();
    
    ImGui::End();
    
    

}






- (void)drawOverlay
{
    
    if (!self.isStartTimer) {
        return;
    }

    if (self.isAimbot || self.isBulletTrack || self.isNorecoil || self.isGunAimbot) {
        
        [self drawAimRangeWithCenter:ImVec2(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5) radius:self.aimbotRadius color:Color::Red numSegments:100 thicknes:0.4];
    }

    int enemyCount = 0;
    for (JFPlayer *player in [TencentAnti TencentGetreal].playerList) {
        if (player.type == PlayerTypeEnemy) {
            enemyCount++;
        }
    }

    [self playerCountEsp:enemyCount];

    for (JFPlayer *player in [TencentAnti TencentGetreal].playerList) {
    
        if (player.isDead || (player.type == PlayerTypeTeam && !self.isTeamMateEsp)) {
            continue;
        }
        
        Color color = Color::White;
        if (player.type == PlayerTypeTeam) {
            color = Color::Yellow;
        } else {
            if (player.isVisible) {
                color = Color::Red;
            } else {
                color = Color::White;
            }
        }
        if (player.type == PlayerTypeEnemy && player.isFallDown) {
            color = Color::Xue2;
        }
       
        if ((self.isAimbot || self.isBulletTrack || self.isGunAimbot) && player.isBestAimTarget) {
            [self drawLineWithStartPoint:ImVec2(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5) endPoint:ImVec2(player.boneData.head.X, player.boneData.head.Y) color:color thicknes:1];
        }
        
        
       // (self.isNorecoil && player.isBestAimTarget) ? self.doubleGun = 0.01 : self.doubleGun = 0.2; //动态无后

        if( (player.boneData.head.X > (SCREEN_WIDTH/2)) || (player.boneData.head.X < (SCREEN_WIDTH/2))){
            self.autoAim = player.SpeedScale*30;
        }
      //  else if(player.boneData.head.X < (SCREEN_WIDTH/2)){
     //       self.autoAim = -player.SpeedScale*3;
      //  }
        else{
            self.autoAim = 0;
        }
        if (self.isTextEsp) {
            [self textEsp:player distanceColor:color];
        }

        
        if (self.isBoxEsp) {
            [self textEspmi:player distanceColor:color];
        }
        
        
        if (self.isHpBarEsp) {
            [self hpBarEsp:player];
        }

    //    if (self.isBoxEsp) {
    //
    //        [self drawRectWithPos:ImVec2(player.box.origin.x, player.box.origin.y) //size:ImVec2(player.box.size.width, player.box.size.height) color:color //thicknes:1];
    //    }

        if (self.isLineEsp) {
            float offset = 5;
    
            if (self.isHpBarEsp) {
                offset += 10;
            }

            if (self.isTextEsp) {
                offset += 20;
            }
          
            [self drawLineWithStartPoint:ImVec2(SCREEN_WIDTH * 0.5, 0) endPoint:ImVec2(player.boneData.head.X, player.boneData.head.Y) color:color thicknes:1];
        }

        if (self.isBoneEsp) {
            [self boneEsp:player];
        }
    }
    for (JFProps *props in [TencentAnti TencentGetreal].propsList) {
        
        if (props.type == PropsTypeWeapon && self.isShowPropsWeapon) {
            [self propsEsp:props color:Color::Quan];
        }

        if (props.type == Flaregun && self.Pistol) {
            [self propsEsp:props color:Color::Quan];
        }
  
        if (props.type == PropsTypeArmor && self.isShowPropsArmor) {
            [self propsEsp:props color:Color(238, 238, 0)];
        }
      
        if (props.type == PropsTypeSight && self.isShowPropsSight) {
            [self propsEsp:props color:Color(238, 238, 0)];
        }
 
        if (props.type == PropsTypeAccessory && self.isShowPropsAccessory) {
            [self propsEsp:props color:Color(238, 238, 0)];
        }

        if (props.type == PropsTypeBullet && self.isShowPropsBullet) {
            [self propsEsp:props  color:Color::Wuqi];
        }

        if (props.type == PropsTypeDrug && self.isShowPropsDrug) {
            [self propsEsp:props color:Color::Yao];
        }

        if (props.type == PickUpListWrapperActor && self.BoxWith) {
                   [self propsEsp:props color:Color::Yao];
               }

        if (props.type == AirDropBox && self.BPc) {
                          [self propsEsp:props color:Color::Yao];
                      }

        if (props.type == PropsTypeVehicle && self.isShowPropsVehicle) {
            [self propsEsp:props color:Color::Che];
        }

        if (props.type == PropsTypeEarlyWarning && self.isShowPropsEarlyWarning) {
            
            [self propsEsp:props color:Color::Red];
      
            if (props.distance <= 10) {
      
                [self drawTextWithText:props.name pos:ImVec2(SCREEN_WIDTH * 0.5, 65) isCentered:true color:Color::Red outline:true fontSize:25];
                   
                [self drawLineWithStartPoint:ImVec2(SCREEN_WIDTH * 0.5, 55) endPoint:ImVec2(props.screenPos.X, props.screenPos.Y) color:Color::Blue thicknes:1];
            }
        }
    }
    
}

- (void)propsEsp:(JFProps *)props color:(Color)color
{
    [self drawTextWithText:string_format("%s [%dm]", props.name.c_str(), props.distance)
                       pos:ImVec2(props.screenPos.X, props.screenPos.Y)
                isCentered:true
                     color:color
                   outline:false
                  fontSize:15];
}

- (void)playerCountEsp:(int)count
{
    [self drawTextWithText:string_format("%d",count)
                       pos:ImVec2(SCREEN_WIDTH * 0.5, 33)
                isCentered:true
                     color:Color::Yellow
                   outline:false
                  fontSize:25];
    
    [self drawTextWithText:string_format("免费获取:www.qmui.club")
                       pos:ImVec2(SCREEN_WIDTH * 0.5, 20)
                isCentered:false
                     color:Color::Red
                   outline:false
                  fontSize:17];
    
    
    
}

- (void)hpBarEsp:(JFPlayer *)player
{
    float rate = 1.0f * player.hp / player.maxHp;
    float width = 70;
    float height = 5.5;
    float x = CGRectGetMidX(player.box) - width * 0.5;
    float y = CGRectGetMinY(player.box) - height - 15;
    
    Color color = Color::Zhen;

   
    
    
    
    
if (rate < 0.35) {
        color = Color::Xue2;
    } else if (rate < 0.75) {
        color = Color::Xue3;
    }

    [self drawRectFilledWithPos:ImVec2(x, y) size:ImVec2(width * rate, height) color:color];

}
- (void)textEsp:(JFPlayer *)player distanceColor:(Color)distanceColor
{
    float width = 100;
    float height = 14;
    float x = CGRectGetMidX(player.box) - width * 0.5;
    float y = CGRectGetMinY(player.box) - height - 10;
    float hpwidth = 140;
    float rate = 1.0f * player.hp / player.maxHp;
    float teamNoWidth = 40;
    

    
 //   ImDrawList* draw_list = ImGui::GetForegroundDrawList();
    
    

//   float Headx = player.boneData.head.X;
//   float Heady = player.boneData.head.Y;
//   {
//
//       [self drawRectFilledWithPos:ImVec2(Headx-40, Heady-11-20)
//                                size:ImVec2(hpwidth * rate, 7)
//                               color:Color::Red];
//
//
//       draw_list->AddRect(ImVec2(Headx-41, Heady-12-20), ImVec2(Headx-24, Heady-4-20), [self getImU32:Color::Orange]);
//
//
//       draw_list->AddRect(ImVec2(Headx-24, Heady-12-20), ImVec2(Headx-8, Heady-4-20), [self getImU32:Color::Orange]);
//
//
//       draw_list->AddRect(ImVec2(Headx-8, Heady-12-20), ImVec2(Headx+8, Heady-4-20), [self getImU32:Color::Orange]);
//
//
//       draw_list->AddRect(ImVec2(Headx+8, Heady-12-20), ImVec2(Headx+24, Heady-4-20), [self getImU32:Color::Orange]);
//
//
//       draw_list->AddRect(ImVec2(Headx+24, Heady-12-20), ImVec2(Headx+40, Heady-4-20), [self getImU32:Color::Orange]);
//
//
//       draw_list->AddRect(ImVec2(Headx-41, Heady-12-20), ImVec2(Headx-24, Heady-4-20), [self getImU32:Color::Orange]);
//
//
//       draw_list->AddRect(ImVec2(Headx-24, Heady-12-20), ImVec2(Headx-8, Heady-4-20), [self getImU32:Color::Orange]);
//
//
//       draw_list->AddRect(ImVec2(Headx-8, Heady-12-20), ImVec2(Headx+8, Heady-4-20), [self getImU32:Color::Orange]);
//
//
//       draw_list->AddRect(ImVec2(Headx+8, Heady-12-20), ImVec2(Headx+24, Heady-4-20), [self getImU32:Color::Orange]);
//
//
//       draw_list->AddRect(ImVec2(Headx+24, Heady-12-20), ImVec2(Headx+40, Heady-4-20), [self getImU32:Color::Orange]);
//
//
//
//   }

    
   // drawRectFilledWithPos:ImVec2(x+15, y-9) size:ImVec2(width * rate, height) color:Color;
    
    int playerx = 1;
    int playery = 3;
    Color teamColor = Color::team_1_1;
    Color nameColor = Color::team_1;
    if(player.teamNo == 1){
     teamColor = Color::team_1_1;
     nameColor = Color::team_1;
    }
    else if(player.teamNo == 2){
     teamColor = Color::team_2_1;
     nameColor = Color::team_2;
    }
    else if(player.teamNo == 3){
     teamColor = Color::team_3_1;
     nameColor = Color::team_3;
    }
    else if(player.teamNo == 4){
     teamColor = Color::team_4_1;
     nameColor = Color::team_4;
    }
    else if(player.teamNo == 5){
     teamColor = Color::team_5_1;
     nameColor = Color::team_5;
    }
    else if(player.teamNo == 6){
     teamColor = Color::team_6_1;
     nameColor = Color::team_6;
    }
    else if(player.teamNo == 7){
     teamColor = Color::team_7_1;
     nameColor = Color::team_7;
    }
    else if(player.teamNo == 8){
     teamColor = Color::team_8_1;
     nameColor = Color::team_8;
    }
    else if(player.teamNo == 9){
     teamColor = Color::team_9_1;
     nameColor = Color::team_9;
    }
    else if(player.teamNo == 10){
     teamColor = Color::team_10_1;
     nameColor = Color::team_10;
    }
    else if(player.teamNo == 11){
     teamColor = Color::team_11_1;
     nameColor = Color::team_11;
    }
    else if(player.teamNo == 12){
     teamColor = Color::team_12_1;
     nameColor = Color::team_12;
    }
    else if(player.teamNo == 13){
     teamColor = Color::team_13_1;
     nameColor = Color::team_13;
    }
    else if(player.teamNo == 14){
     teamColor = Color::team_14_1;
     nameColor = Color::team_14;
    }
    else if(player.teamNo == 15){
     teamColor = Color::team_15_1;
     nameColor = Color::team_15;
    }
    else if(player.teamNo == 16){
     teamColor = Color::team_16_1;
     nameColor = Color::team_16;
    }
    else if(player.teamNo == 17){
     teamColor = Color::team_17_1;
     nameColor = Color::team_17;
    }
    else if(player.teamNo == 18){
     teamColor = Color::team_18_1;
     nameColor = Color::team_18;
    }
    else if(player.teamNo == 19){
     teamColor = Color::team_19_1;
     nameColor = Color::team_19;
    }
    else if(player.teamNo == 20){
     teamColor = Color::team_20_1;
     nameColor = Color::team_20;
    }
    else if(player.teamNo == 21){
     teamColor = Color::team_21_1;
     nameColor = Color::team_21;
    }
    else if(player.teamNo == 22){
     teamColor = Color::team_22_1;
     nameColor = Color::team_22;
    }
    else if(player.teamNo == 23){
     teamColor = Color::team_23_1;
     nameColor = Color::team_23;
    }
    else if(player.teamNo == 24){
     teamColor = Color::team_24_1;
     nameColor = Color::team_24;
    }
    else if(player.teamNo == 25){
     teamColor = Color::team_25_1;
     nameColor = Color::team_25;
    }
    
    
    if (x > IOSW && y < IOSH && y >0) {//右边框
        [self drawRectFilledWithPos:ImVec2( IOSW-40, y )
                               size:ImVec2( 30, 20)
                              color:teamColor];
        
        string distance = string_format("%d米", player.distance);
        [self drawTextWithText:distance
                           pos:ImVec2( IOSW-35, y )
                    isCentered:false
                         color:Color::White
                       outline:false
                      fontSize:21];
    }
    else if (x < 0 && y < IOSH && y > 0){//左边框
        [self drawRectFilledWithPos:ImVec2( 10, y )
                               size:ImVec2( 30, 20)
                              color:teamColor];
        
        string distance = string_format("%d米", player.distance);
        [self drawTextWithText:distance
                           pos:ImVec2( 15, y )
                    isCentered:false
                         color:Color::White
                       outline:false
                      fontSize:21];
    }
    else if(y < 0 && x > 0 && x < IOSW){//上边框
        [self drawRectFilledWithPos:ImVec2( x, 30 )
                               size:ImVec2( 30, 20)
                              color:teamColor];
        
        string distance = string_format("%d米", player.distance);
        [self drawTextWithText:distance
                           pos:ImVec2( x+5, 30 )
                    isCentered:false
                         color:Color::White
                       outline:false
                      fontSize:21];
    }
    else if(y > IOSH && x > 0 && x <IOSW){//下边框
        [self drawRectFilledWithPos:ImVec2( x, IOSH -30 )
                               size:ImVec2( 30, 20)
                              color:teamColor];
        
        string distance = string_format("%d米", player.distance);
        [self drawTextWithText:distance
                           pos:ImVec2( x+5, IOSH -30 )
                    isCentered:false
                         color:Color::White
                       outline:false
                      fontSize:21];
    }
  //  else if(y > IOSH && x >IOSW){//右下角
  //      [self drawRectFilledWithPos:ImVec2( IOSW - 40, IOSH -30 )
  //                             size:ImVec2( 30, 20)
  //                            color:teamColor];
  //
  //      string distance = string_format("%d米", player.distance);
  //      [self drawTextWithText:distance
  //                         pos:ImVec2( IOSW - 40, IOSH -30 )
  //                  isCentered:false
  //                       color:Color::White
  //                     outline:false
  //                    fontSize:21];
  //  }
  //  else if(y < 0 && x >IOSW){//右上角
  //      [self drawRectFilledWithPos:ImVec2( IOSW - 40, 30 )
  //                             size:ImVec2( 30, 20)
  //                            color:teamColor];
  //
  //      string distance = string_format("%d米", player.distance);
  //      [self drawTextWithText:distance
  //                         pos:ImVec2( IOSW - 40, 30 )
  //                  isCentered:false
  //                       color:Color::White
  //                     outline:false
  //                    fontSize:21];
  //  }
  //  else if(y > IOSH && x < 0){//左下角
  //      [self drawRectFilledWithPos:ImVec2(  10,  IOSH -30 )
  //                             size:ImVec2( 30, 20)
  //                            color:teamColor];
  //
  //      string distance = string_format("%d米", player.distance);
  //      [self drawTextWithText:distance
  //                         pos:ImVec2( 10, 30 )
  //                  isCentered:false
  //                       color:Color::White
  //                     outline:false
  //                    fontSize:21];
  //  }
  //  else if(y > 0 && x > 0 ){//左上角
  //      [self drawRectFilledWithPos:ImVec2(  10,  30 )
  //                             size:ImVec2( 30, 20)
  //                            color:teamColor];
  //
  //      string distance = string_format("%d米", player.distance);
  //      [self drawTextWithText:distance
  //                         pos:ImVec2( 10, 30 )
  //                  isCentered:false
  //                       color:Color::White
  //                     outline:false
  //                    fontSize:21];
  //  }

    
  //  if(player.teamNo == 1){
    //对标背景框
    [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
                           size:ImVec2( 25, 19)
                          color:teamColor];
 
   //名字背景框
    [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
                           size:ImVec2(115, 19)
                          color:nameColor];
        //下标背景框
   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
                            color:teamColor];
  //  }
 //
 //    else if(player.teamNo == 2){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_2_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_2];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_2_1];
 //   }
 //
 //    else if(player.teamNo == 3){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_3_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_3];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_3_1];
 //   }
 //
 //    else if(player.teamNo == 4){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_4_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_4];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_4_1];
 //   }
 //
 //    else if(player.teamNo == 5){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_5_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_5];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_5_1];
 //   }
 //
 //    else if(player.teamNo == 6){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_6_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_6];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_6_1];
 //   }
 //
 //    else if(player.teamNo == 7){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_7_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_7];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_7_1];
 //   }
 //
 //    else if(player.teamNo == 8){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_8_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_8];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_8_1];
 //   }
 //
 //    else if(player.teamNo == 9){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_9_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_9];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_9_1];
 //   }
 //
 //    else if(player.teamNo == 10){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_10_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_10];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_10_1];
 //   }
 //
 //    else if(player.teamNo == 11){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_11_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_11];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_11_1];
 //   }
 //
 //    else if(player.teamNo == 12){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_12_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_12];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_12_1];
 //   }
 //
 //    else if(player.teamNo == 13){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_13_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_13];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_13_1];
 //   }
 //
 //    else if(player.teamNo == 14){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_14_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_14];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_14_1];
 //   }
 //
 //    else if(player.teamNo == 15){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_15_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_15];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_15_1];
 //   }
 //
 //    else if(player.teamNo == 16){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_16_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_16];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_16_1];
 //   }
 //
 //    else if(player.teamNo == 17){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_17_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_17];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_17_1];
 //   }
 //
 //    else if(player.teamNo == 18){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_18_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_18];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_18_1];
 //   }
 //
 //    else if(player.teamNo == 19){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_19_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_19];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_19_1];
 //   }
 //    else if(player.teamNo == 20){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_20_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_20];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_20_1];
 //   }
 //
 //    else if(player.teamNo == 21){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_21_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_21];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_21_1];
 //   }
 //
 //    else if(player.teamNo == 22){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_22_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_22];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_22_1];
 //   }
 //
 //    else if(player.teamNo == 23){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_23_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_23];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_23_1];
 //   }
 //
 //    else if(player.teamNo == 24){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_24_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_24];
 //
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_24_1];
 //   }
 //    else if(player.teamNo == 25){
 //   //对标背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                          size:ImVec2( 25, 19)
 //                         color:Color::team_25_1];
 //
 //  //名字背景框
 //   [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                          size:ImVec2(115, 19)
 //                         color:Color::team_25];
 //        //下标背景框
 //   [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                            P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                            P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                            color:Color::team_25_1];
 //
 //   }else{
 //      //对标背景框
 //      [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -playery)
 //                             size:ImVec2( 25, 19)
 //                            color:Color::team_21_1];
 //
 //     //名字背景框
 //      [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 + 20-3-40, y -playery)
 //                             size:ImVec2(115, 19)
 //                            color:Color::team_21];
 //           //下标背景框
 //      [self DrawTriangleFilled:ImVec2(x + teamNoWidth * 0.8 + 20-3-12, y -3 + 20)
 //                               P2:ImVec2(x + teamNoWidth * 0.8 + 20-3+16, y -3 + 20)
 //                               P3:ImVec2(x + teamNoWidth * 0.8 + 20-3+2, y -3 + 20 +12)
 //                               color:Color::team_21_1];
 //      }
 //
 //
 //
  //队标
    [self drawTextWithText:string_format("%d", player.teamNo)
                      pos:ImVec2(x + teamNoWidth * 0.8 + 1-43, y -playery-2)
               isCentered:false
                    color:Color::White
                  outline:false
                 fontSize:22];
    
    
    if(aiint){
    if(player.distance >= 80){
        _aimbotPart = 4;
    }else{
        _aimbotPart = 6;
    }
    }
    
    
    
    string name = string_format("%s",player.name.c_str());
    
    size_t i;
    size_t len = name.length();
    size_t offset = 0;
    for(i = 0; i < len; ++i){
        char c = name[i];
        if(c=='?'||c==' ') ++offset;
        else name[i-offset] = c;
    }
   // name.replace("?","");
    //name = name.replaceAll("?","");//把?替换为空字符转


    //名字
    [self drawTextWithText:name
                       pos:ImVec2(x + teamNoWidth * 0.8 + 20-3-38, y -playery)
                isCentered:false
                     color:Color::White
                   outline:false
                  fontSize:18];
    
    string distance = string_format("%d米  武器", player.distance);
    [self drawTextWithText:distance
                       pos:ImVec2(x + teamNoWidth * 0.8 + 20-3-38, y -playery-21)
                isCentered:false
                     color:Color::White
                   outline:false
                  fontSize:18];

    

    //距离
  //  string distance = string_format("%d", player.distance);
  //  ImVec2 distanceSize = _espFont->CalcTextSizeA(9.5, MAXFLOAT, 0.0f, distance.c_str());
  //  [self drawTextWithText:distance
  //                     pos:ImVec2(x + teamNoWidth * 0.8 + 15 + 10-2, y -3 -24)
  //              isCentered:true
  //                   color:Color::White
  //                 outline:true
  //                fontSize:22];
    
    //血条
    [self drawRectFilledWithPos:ImVec2(x + teamNoWidth * 0.8 -5-3-40, y -3 + 20 -3)
                           size:ImVec2(hpwidth * rate, 3)
                          color:Color::xuewhite];

}
- (void)textEspmi:(JFPlayer *)player distanceColor:(Color)distanceColor
{
   // float width = 100;
    float height = 14;
   // float x = CGRectGetMidX(player.box) - width * 0.5 ;
    float y = CGRectGetMinY(player.box) - height - 10 ;
}



- (void)boneEsp:(JFPlayer *)player
{
    if (player.isAI) {
        Color invisibleColor = Color::Green;
        Color visibleColor = Color::Red;
        float thicknes = 1;

        [self drawCircleWithCenter:ImVec2(player.boneData.head.X, player.boneData.head.Y-3) radius:CGRectGetWidth(player.box) * 0.15f color:player.boneVisibleData.head ? visibleColor : invisibleColor numSegments:15 thicknes:1.3];
        
        [self drawLineWithStartPoint:ImVec2(player.boneData.chest.X, player.boneData.chest.Y) endPoint:ImVec2(player.boneData.pelvis.X, player.boneData.pelvis.Y) color:player.boneVisibleData.chest ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.chest.X, player.boneData.chest.Y) endPoint:ImVec2(player.boneData.leftShoulder.X, player.boneData.leftShoulder.Y) color:player.boneVisibleData.chest ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.chest.X, player.boneData.chest.Y) endPoint:ImVec2(player.boneData.rightShoulder.X, player.boneData.rightShoulder.Y) color:player.boneVisibleData.chest ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.leftShoulder.X, player.boneData.leftShoulder.Y) endPoint:ImVec2(player.boneData.leftElbow.X, player.boneData.leftElbow.Y) color:player.boneVisibleData.leftShoulder ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.rightShoulder.X, player.boneData.rightShoulder.Y) endPoint:ImVec2(player.boneData.rightElbow.X, player.boneData.rightElbow.Y) color:player.boneVisibleData.rightShoulder ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.pelvis.X, player.boneData.pelvis.Y) endPoint:ImVec2(player.boneData.leftThigh.X, player.boneData.leftThigh.Y) color:player.boneVisibleData.pelvis ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.pelvis.X, player.boneData.pelvis.Y) endPoint:ImVec2(player.boneData.rightThigh.X, player.boneData.rightThigh.Y) color:player.boneVisibleData.pelvis ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.leftElbow.X, player.boneData.leftElbow.Y) endPoint:ImVec2(player.boneData.leftHand.X, player.boneData.leftHand.Y) color:player.boneVisibleData.leftElbow ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.rightElbow.X, player.boneData.rightElbow.Y) endPoint:ImVec2(player.boneData.rightHand.X, player.boneData.rightHand.Y) color:player.boneVisibleData.rightElbow ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.leftThigh.X, player.boneData.leftThigh.Y) endPoint:ImVec2(player.boneData.leftKnee.X, player.boneData.leftKnee.Y) color:player.boneVisibleData.leftThigh ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.rightThigh.X, player.boneData.rightThigh.Y) endPoint:ImVec2(player.boneData.rightKnee.X, player.boneData.rightKnee.Y) color:player.boneVisibleData.rightThigh ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.leftKnee.X, player.boneData.leftKnee.Y) endPoint:ImVec2(player.boneData.leftFoot.X, player.boneData.leftFoot.Y) color:player.boneVisibleData.leftKnee ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.rightKnee.X, player.boneData.rightKnee.Y) endPoint:ImVec2(player.boneData.rightFoot.X, player.boneData.rightFoot.Y) color:player.boneVisibleData.rightKnee ? visibleColor : invisibleColor thicknes:thicknes];
    }
    else{
        Color invisibleColor = Color::White;
        Color visibleColor = Color::Red;
        float thicknes = 1;

        [self drawCircleWithCenter:ImVec2(player.boneData.head.X, player.boneData.head.Y-3) radius:CGRectGetWidth(player.box) * 0.15f color:player.boneVisibleData.head ? visibleColor : invisibleColor numSegments:15 thicknes:1.3];
        
        [self drawLineWithStartPoint:ImVec2(player.boneData.chest.X, player.boneData.chest.Y) endPoint:ImVec2(player.boneData.pelvis.X, player.boneData.pelvis.Y) color:player.boneVisibleData.chest ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.chest.X, player.boneData.chest.Y) endPoint:ImVec2(player.boneData.leftShoulder.X, player.boneData.leftShoulder.Y) color:player.boneVisibleData.chest ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.chest.X, player.boneData.chest.Y) endPoint:ImVec2(player.boneData.rightShoulder.X, player.boneData.rightShoulder.Y) color:player.boneVisibleData.chest ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.leftShoulder.X, player.boneData.leftShoulder.Y) endPoint:ImVec2(player.boneData.leftElbow.X, player.boneData.leftElbow.Y) color:player.boneVisibleData.leftShoulder ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.rightShoulder.X, player.boneData.rightShoulder.Y) endPoint:ImVec2(player.boneData.rightElbow.X, player.boneData.rightElbow.Y) color:player.boneVisibleData.rightShoulder ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.pelvis.X, player.boneData.pelvis.Y) endPoint:ImVec2(player.boneData.leftThigh.X, player.boneData.leftThigh.Y) color:player.boneVisibleData.pelvis ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.pelvis.X, player.boneData.pelvis.Y) endPoint:ImVec2(player.boneData.rightThigh.X, player.boneData.rightThigh.Y) color:player.boneVisibleData.pelvis ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.leftElbow.X, player.boneData.leftElbow.Y) endPoint:ImVec2(player.boneData.leftHand.X, player.boneData.leftHand.Y) color:player.boneVisibleData.leftElbow ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.rightElbow.X, player.boneData.rightElbow.Y) endPoint:ImVec2(player.boneData.rightHand.X, player.boneData.rightHand.Y) color:player.boneVisibleData.rightElbow ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.leftThigh.X, player.boneData.leftThigh.Y) endPoint:ImVec2(player.boneData.leftKnee.X, player.boneData.leftKnee.Y) color:player.boneVisibleData.leftThigh ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.rightThigh.X, player.boneData.rightThigh.Y) endPoint:ImVec2(player.boneData.rightKnee.X, player.boneData.rightKnee.Y) color:player.boneVisibleData.rightThigh ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.leftKnee.X, player.boneData.leftKnee.Y) endPoint:ImVec2(player.boneData.leftFoot.X, player.boneData.leftFoot.Y) color:player.boneVisibleData.leftKnee ? visibleColor : invisibleColor thicknes:thicknes];
        [self drawLineWithStartPoint:ImVec2(player.boneData.rightKnee.X, player.boneData.rightKnee.Y) endPoint:ImVec2(player.boneData.rightFoot.X, player.boneData.rightFoot.Y) color:player.boneVisibleData.rightKnee ? visibleColor : invisibleColor thicknes:thicknes];
    }


    
}


- (void)drawAimRangeWithCenter:(ImVec2)center radius:(float)radius color:(Color)color numSegments:(int)numSegments thicknes:(float)thicknes
{
    ImGui::GetOverlayDrawList()->AddCircle(center, radius, [self getImU32:color], numSegments, thicknes);
}
- (void)drawLineWithStartPoint:(ImVec2)startPoint endPoint:(ImVec2)endPoint color:(Color)color thicknes:(float)thicknes
{
    ImGui::GetBackgroundDrawList()->AddLine(startPoint, endPoint, [self getImU32:color], thicknes);
   // ImGui::GetBackgroundDrawList()-AddCircleFilled(ImVec2(50, 50), 15, Color::White, thicknes);// Circle添加填充的圆
}

- (void)drawCircleWithCenter:(ImVec2)center radius:(float)radius color:(Color)color numSegments:(int)numSegments thicknes:(float)thicknes
{
    ImGui::GetBackgroundDrawList()->AddCircle(center, radius, [self getImU32:color], numSegments, thicknes);
}



- (void)drawCircleFilledWithCenter:(ImVec2)center radius:(float)radius color:(Color)color numSegments:(int)numSegments
{
    ImGui::GetBackgroundDrawList()->AddCircleFilled(center, radius, [self getImU32:color], numSegments);
}
- (void)drawTextWithText:(string)text pos:(ImVec2)pos isCentered:(bool)isCentered color:(Color)color outline:(bool)outline fontSize:(float)fontSize
{
    const char *str = text.c_str();
    ImVec2 vec2 = pos;
    if (isCentered) {
        ImVec2 textSize = _espFont2->CalcTextSizeA(fontSize, MAXFLOAT, 1.0f, str);
        vec2.x -= textSize.x * 0.5f;
    }//qq
    if (outline)
    {
        ImU32 outlineColor = [self getImU32:Color::Black];//
        ImGui::GetBackgroundDrawList()->AddText(_espFont2, fontSize, ImVec2(vec2.x + 1, vec2.y + 1), outlineColor, str);
        ImGui::GetBackgroundDrawList()->AddText(_espFont2, fontSize, ImVec2(vec2.x - 1, vec2.y - 1), outlineColor, str);
        ImGui::GetBackgroundDrawList()->AddText(_espFont2, fontSize, ImVec2(vec2.x + 1, vec2.y - 1), outlineColor, str);
        ImGui::GetBackgroundDrawList()->AddText(_espFont2, fontSize, ImVec2(vec2.x - 1, vec2.y + 1), outlineColor, str);
    }
    ImGui::GetBackgroundDrawList()->AddText(_espFont2, fontSize, vec2, [self getImU32:color], str);
}

- (void)drawRectWithPos:(ImVec2)pos size:(ImVec2)size color:(Color)color thicknes:(float)thicknes
{
    ImGui::GetBackgroundDrawList()->AddRect(pos, ImVec2(pos.x + size.x, pos.y + size.y), [self getImU32:color], 0, 0, thicknes);
}

- (void)drawRectFilledWithPos:(ImVec2)pos size:(ImVec2)size color:(Color)color
{
    ImGui::GetBackgroundDrawList()->AddRectFilled(pos, ImVec2(pos.x + size.x, pos.y + size.y), [self getImU32:color], 0, 0);
}

- (void)DrawTriangleFilled:(ImVec2)p1 P2:(ImVec2)p2 P3:(ImVec2)p3 color:(Color)color
{
    ImGui::GetBackgroundDrawList()->AddTriangleFilled(p1, p2, p3,[self getImU32:color]);   //三角形
}

- (ImU32)getImU32:(Color)color
{
    return ((color.a & 0xff) << 24) + ((color.b & 0xff) << 16) + ((color.g & 0xff) << 8) + (color.r & 0xff);
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.renderer handleEvent:event view:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.renderer handleEvent:event view:self];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.renderer handleEvent:event view:self];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.renderer handleEvent:event view:self];
}

@end
