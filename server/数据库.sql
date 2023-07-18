-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2023-06-20 12:56:12
-- 服务器版本： 5.7.26
-- PHP 版本： 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_article`
--

CREATE TABLE `fox_chatgpt_article` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `thumb` varchar(255) DEFAULT NULL,
  `content` longtext,
  `weight` int(11) DEFAULT '100' COMMENT '越大越靠前',
  `views` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_card`
--

CREATE TABLE `fox_chatgpt_card` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `batch_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `code` varchar(255) DEFAULT '0' COMMENT '卡密',
  `type` varchar(10) DEFAULT NULL,
  `val` int(11) DEFAULT '0',
  `bind_time` int(11) DEFAULT '0' COMMENT '使用时间',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_card_batch`
--

CREATE TABLE `fox_chatgpt_card_batch` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `num` int(11) DEFAULT '0' COMMENT '数量',
  `type` varchar(10) DEFAULT NULL,
  `val` int(11) DEFAULT '0',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_commission_apply`
--

CREATE TABLE `fox_chatgpt_commission_apply` (
  `id` int(11) UNSIGNED NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0' COMMENT '用户表id',
  `level` int(11) DEFAULT '1',
  `pid` int(11) DEFAULT '0' COMMENT '上级user_id',
  `name` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '分销商姓名',
  `phone` varchar(20) CHARACTER SET utf8 DEFAULT '0' COMMENT '手机号',
  `idcard` varchar(20) CHARACTER SET utf8 DEFAULT NULL COMMENT '身份证号',
  `invite_code` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '邀请码',
  `total_fee` int(11) DEFAULT '0' COMMENT '需支付金额',
  `platform` varchar(20) CHARACTER SET utf8 DEFAULT 'wxapp' COMMENT '申请来源wxapp/app',
  `pay_type` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `pay_time` int(11) DEFAULT NULL,
  `transaction_id` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '0未审核 1审核成功 2驳回',
  `reject_reason` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '驳回原因',
  `remark` text CHARACTER SET utf8 COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '0未删除1已删除',
  `audit_time` int(11) DEFAULT '0' COMMENT '审核时间',
  `create_time` int(10) DEFAULT '0' COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_commission_bill`
--

CREATE TABLE `fox_chatgpt_commission_bill` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT '0',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` tinyint(1) DEFAULT '1' COMMENT '1收入 2提现 3退款 4提现退回',
  `money` int(11) DEFAULT NULL,
  `is_lock` tinyint(1) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_commission_withdraw`
--

CREATE TABLE `fox_chatgpt_commission_withdraw` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `money` int(11) DEFAULT '0' COMMENT '提现金额（分）',
  `bank_name` varchar(100) DEFAULT NULL,
  `account_name` varchar(50) DEFAULT NULL,
  `account_number` varchar(100) DEFAULT NULL,
  `qrcode` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '0待审核 1已打款 2已驳回',
  `audit_time` int(11) DEFAULT '0' COMMENT '审核时间',
  `reject_reason` varchar(255) DEFAULT NULL COMMENT '拒绝原因',
  `remark` varchar(255) DEFAULT NULL COMMENT '后台备注',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_cosplay_role`
--

CREATE TABLE `fox_chatgpt_cosplay_role` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT '0',
  `title` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `desc` varchar(1000) CHARACTER SET utf8mb4 DEFAULT NULL,
  `thumb` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prompt` text COLLATE utf8mb4_unicode_ci,
  `hint` varchar(1000) CHARACTER SET utf8mb4 DEFAULT NULL,
  `welcome` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `views` int(11) DEFAULT '0',
  `usages` int(11) DEFAULT '0',
  `fake_views` int(11) DEFAULT '0',
  `fake_usages` int(11) DEFAULT '0',
  `weight` int(11) DEFAULT '100',
  `state` tinyint(1) DEFAULT '1',
  `is_delete` tinyint(1) DEFAULT '0',
  `update_time` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_cosplay_type`
--

CREATE TABLE `fox_chatgpt_cosplay_type` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `weight` int(11) DEFAULT '100' COMMENT '大的靠前',
  `state` tinyint(1) DEFAULT '1',
  `update_time` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_draw`
--

CREATE TABLE `fox_chatgpt_draw` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL COMMENT '产品标题',
  `price` int(11) DEFAULT '0' COMMENT '现价',
  `market_price` int(11) DEFAULT '0' COMMENT '市场价',
  `num` int(11) DEFAULT '0' COMMENT '条数',
  `hint` varchar(20) DEFAULT NULL,
  `desc` text,
  `sales` int(11) DEFAULT '0' COMMENT '销量',
  `status` tinyint(1) DEFAULT '1',
  `weight` int(11) DEFAULT '100' COMMENT '越大越靠前',
  `is_default` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_engine`
--

CREATE TABLE `fox_chatgpt_engine` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT '1',
  `type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `fox_chatgpt_engine`
--

INSERT INTO `fox_chatgpt_engine` (`id`, `title`, `name`, `state`, `type`) VALUES
(1, 'gpt-3.5-turbo', 'gpt-3.5-turbo', 1, 'GPT3.5'),
(2, 'gpt-3.5-turbo-0613', 'gpt-3.5-turbo-0613', 1, 'GPT3.5'),
(3, 'gpt-3.5-turbo-16k', 'gpt-3.5-turbo-16k', 1, 'GPT3.5'),
(4, 'gpt-3.5-turbo-16k-0613', 'gpt-3.5-turbo-16k-0613', 1, 'GPT3.5'),
(5, 'gpt-4', 'gpt-4', 1, 'GPT4'),
(6, 'gpt-4-0613', 'gpt-4-0613', 1, 'GPT4'),
(7, 'gpt-4-32k', 'gpt-4-32k', 1, 'GPT4'),
(8, 'gpt-4-32k-0613', 'gpt-4-32k-0613', 1, 'GPT4');

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_feedback`
--

CREATE TABLE `fox_chatgpt_feedback` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `content` text,
  `phone` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT '0' COMMENT '0未处理 1已处理',
  `is_delete` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_goods`
--

CREATE TABLE `fox_chatgpt_goods` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL COMMENT '产品标题',
  `price` int(11) DEFAULT '0' COMMENT '现价',
  `market_price` int(11) DEFAULT '0' COMMENT '市场价',
  `num` int(11) DEFAULT '0' COMMENT '条数',
  `hint` varchar(255) DEFAULT NULL,
  `desc` text,
  `sales` int(11) DEFAULT '0' COMMENT '销量',
  `status` tinyint(1) DEFAULT '1',
  `weight` int(11) DEFAULT '100' COMMENT '越大越靠前',
  `is_default` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_gpt4`
--

CREATE TABLE `fox_chatgpt_gpt4` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL COMMENT '产品标题',
  `price` int(11) DEFAULT '0' COMMENT '现价',
  `market_price` int(11) DEFAULT '0' COMMENT '市场价',
  `num` int(11) DEFAULT '0' COMMENT '条数',
  `hint` varchar(20) DEFAULT NULL,
  `desc` text,
  `sales` int(11) DEFAULT '0' COMMENT '销量',
  `status` tinyint(1) DEFAULT '1',
  `weight` int(11) DEFAULT '100' COMMENT '越大越靠前',
  `is_default` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_keys`
--

CREATE TABLE `fox_chatgpt_keys` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `type` varchar(10) DEFAULT 'openai',
  `key` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT '1',
  `stop_reason` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `last_time` int(11) DEFAULT '0' COMMENT '最后使用时间',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_logs`
--

CREATE TABLE `fox_chatgpt_logs` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `content` text,
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统日志';

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_msg`
--

CREATE TABLE `fox_chatgpt_msg` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `group_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `openid` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `message` text,
  `message_input` text,
  `total_tokens` int(11) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='聊天消息';

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_msg_cosplay`
--

CREATE TABLE `fox_chatgpt_msg_cosplay` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT '0',
  `role_id` int(11) DEFAULT '0',
  `channel` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `message` longtext,
  `message_input` longtext,
  `response` longtext,
  `response_input` longtext,
  `total_tokens` int(11) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='【角色模拟】的聊天消息' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_msg_draw`
--

CREATE TABLE `fox_chatgpt_msg_draw` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `platform` varchar(20) DEFAULT NULL,
  `channel` varchar(20) DEFAULT NULL,
  `message` text,
  `message_input` text,
  `images` text,
  `size` varchar(20) DEFAULT NULL,
  `num` tinyint(1) DEFAULT '1',
  `state` tinyint(1) DEFAULT '0' COMMENT '0生成中 1成功 2失败',
  `errmsg` varchar(255) DEFAULT NULL,
  `is_delete` tinyint(1) DEFAULT '0',
  `finish_time` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_msg_group`
--

CREATE TABLE `fox_chatgpt_msg_group` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `is_delete` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_msg_web`
--

CREATE TABLE `fox_chatgpt_msg_web` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT '0',
  `topic_id` int(11) DEFAULT '0',
  `activity_id` int(11) DEFAULT '0',
  `prompt_id` int(11) DEFAULT '0',
  `channel` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `message` longtext,
  `message_input` longtext,
  `response` longtext,
  `response_input` longtext,
  `total_tokens` int(11) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='【web】的聊天消息' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_msg_write`
--

CREATE TABLE `fox_chatgpt_msg_write` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `openid` varchar(255) DEFAULT NULL,
  `topic_id` int(11) DEFAULT '0',
  `activity_id` int(11) DEFAULT '0',
  `prompt_id` int(11) DEFAULT '0',
  `channel` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `message` longtext,
  `message_input` longtext,
  `response` longtext,
  `response_input` longtext,
  `text_request` longtext,
  `total_tokens` int(11) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='【创作】的聊天消息' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_order`
--

CREATE TABLE `fox_chatgpt_order` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `goods_id` int(11) DEFAULT '0',
  `draw_id` int(11) DEFAULT '0',
  `gpt4_id` int(11) DEFAULT '0',
  `vip_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL COMMENT '支付宝user_id',
  `openid` varchar(255) DEFAULT NULL,
  `out_trade_no` varchar(255) DEFAULT '',
  `transaction_id` varchar(255) DEFAULT '',
  `total_fee` int(11) DEFAULT '0',
  `pay_type` varchar(20) DEFAULT 'alipay' COMMENT 'alipay/wxpay',
  `pay_time` int(11) DEFAULT '0',
  `commission1` int(11) DEFAULT '0' COMMENT '上级分销商id',
  `commission2` int(11) DEFAULT '0' COMMENT '上上级分销商',
  `commission1_fee` int(11) DEFAULT '0' COMMENT '上级佣金金额',
  `commission2_fee` int(11) DEFAULT '0' COMMENT '上上级佣金金额',
  `is_refund` tinyint(1) DEFAULT '0' COMMENT '是否已退款',
  `remark` varchar(255) DEFAULT '',
  `status` tinyint(1) DEFAULT '0' COMMENT '0未付款 1成功',
  `num` int(11) DEFAULT '0' COMMENT '充值条数',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_pclogin`
--

CREATE TABLE `fox_chatgpt_pclogin` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `openid` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_reward_ad`
--

CREATE TABLE `fox_chatgpt_reward_ad` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `reward_num` int(11) DEFAULT '0' COMMENT '奖励条数',
  `ad_unit_id` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_reward_invite`
--

CREATE TABLE `fox_chatgpt_reward_invite` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0' COMMENT '邀请人id',
  `share_id` int(11) DEFAULT '0' COMMENT '分享id',
  `way` varchar(255) DEFAULT NULL,
  `newuser_id` int(11) DEFAULT '0' COMMENT '新用户id',
  `reward_num` int(11) DEFAULT '0' COMMENT '奖励条数',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_reward_share`
--

CREATE TABLE `fox_chatgpt_reward_share` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `way` varchar(255) DEFAULT NULL,
  `is_reward` tinyint(1) DEFAULT '0',
  `views` int(11) DEFAULT '0',
  `invite_num` int(11) DEFAULT '0' COMMENT '邀请到新用户数量',
  `reward_num` int(11) DEFAULT '0' COMMENT '分享奖励条数',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_setting`
--

CREATE TABLE `fox_chatgpt_setting` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `ad` text COMMENT '支付后广告',
  `version` varchar(50) DEFAULT NULL COMMENT '系统版本号',
  `system` text COMMENT '系统配置',
  `auth` text,
  `tplnotice` text,
  `wxapp` text,
  `wxapp_upload` text,
  `wxapp_index` text,
  `pay` text,
  `chatgpt` text,
  `gpt4` text,
  `filter` text,
  `reward_share` text,
  `reward_invite` text,
  `reward_ad` text,
  `api` text,
  `about` text,
  `commission` text,
  `web` text,
  `wxmp` text,
  `h5` text,
  `kefu` text,
  `chat` text,
  `draw` text,
  `storage` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `fox_chatgpt_setting`
--

INSERT INTO `fox_chatgpt_setting` (`id`, `site_id`, `ad`, `version`, `system`, `auth`, `tplnotice`, `wxapp`, `wxapp_upload`, `wxapp_index`, `pay`, `chatgpt`, `gpt4`, `filter`, `reward_share`, `reward_invite`, `reward_ad`, `api`, `about`, `commission`, `web`, `wxmp`, `h5`, `kefu`, `chat`, `draw`, `storage`) VALUES
(1, 0, NULL, 'v2.0.4', '{\"system_title\":\"付费体验系统\",\"system_logo\":\"https://www.jikym.cn/\",\"system_icp\":\"\",\"system_gongan\":\"\"}', '{\"code\":\"1\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"handle_type\":1}', NULL, NULL, NULL, '{\"channel\":\"gpt\",\"host\":\"http://www.jikym.cn\",\"key\":\"123123\",\"outtype\":\"nostream\",\"agent_host\":\"http://www.jikym.cn\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"engine\":\"alioss\",\"alioss_region\":\"www.jikym.cn\",\"alioss_domain\":\"https://www.jikym.cn\",\"alioss_access_key_id\":\"1\",\"alioss_access_key_secret\":\"1\",\"alioss_bucket\":\"1\"}'),
(2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"is_open\":1,\"bind_wxapp_user\":1,\"page_title\":\"11\",\"copyright\":\"\",\"copyright_link\":\"\"}', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_site`
--

CREATE TABLE `fox_chatgpt_site` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT '昵称',
  `sitecode` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT '/static/img/avatar.png',
  `remark` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `expire_time` int(11) DEFAULT '0',
  `last_time` int(11) DEFAULT '0' COMMENT '最后登录时间',
  `last_ip` varchar(20) DEFAULT NULL,
  `is_delete` tinyint(1) DEFAULT '0',
  `token` varchar(255) DEFAULT NULL COMMENT '自动登录token',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员表';

--
-- 转存表中的数据 `fox_chatgpt_site`
--

INSERT INTO `fox_chatgpt_site` (`id`, `title`, `sitecode`, `phone`, `password`, `avatar`, `remark`, `status`, `expire_time`, `last_time`, `last_ip`, `is_delete`, `token`, `create_time`) VALUES
(1, '默认站点', 'jkym', 'admin', '123456', '/static/img/avatar.png', NULL, 1, 0, 1683817463, '1', 0, '646cd21b68c8e5121', 1675991002);

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_super`
--

CREATE TABLE `fox_chatgpt_super` (
  `id` int(11) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(20) DEFAULT '' COMMENT '角色',
  `realname` varchar(255) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) DEFAULT '/static/img/avatar.png',
  `remark` varchar(255) DEFAULT NULL,
  `last_time` int(11) DEFAULT '0' COMMENT '最后登录时间',
  `last_ip` varchar(20) DEFAULT NULL,
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `fox_chatgpt_super`
--

INSERT INTO `fox_chatgpt_super` (`id`, `phone`, `password`, `role`, `realname`, `avatar`, `remark`, `last_time`, `last_ip`, `create_time`) VALUES
(1, 'super', '123456', 'super', '超级管理员', '/static/img/avatar.png', NULL, 1676695437, '127.0.0.1', 1676695437);

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_user`
--

CREATE TABLE `fox_chatgpt_user` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `openid` varchar(50) DEFAULT NULL COMMENT '小程序openid',
  `openid_mp` varchar(255) DEFAULT NULL COMMENT '公众号openid',
  `unionid` varchar(255) DEFAULT NULL,
  `balance` int(11) DEFAULT '0' COMMENT '对话余额',
  `balance_draw` int(11) DEFAULT '0' COMMENT '绘画余额',
  `balance_gpt4` bigint(20) DEFAULT '0' COMMENT 'GPT4余额',
  `vip_expire_time` bigint(20) DEFAULT '0' COMMENT 'vip到期时间',
  `avatar` varchar(255) DEFAULT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `tuid` int(11) DEFAULT '0' COMMENT '推荐人ID',
  `commission_level` int(11) DEFAULT '0' COMMENT '分销等级（暂留）',
  `commission_money` int(11) DEFAULT '0' COMMENT '可提现佣金余额',
  `commission_paid` int(11) DEFAULT '0' COMMENT '已提现佣金',
  `commission_frozen` int(11) DEFAULT '0' COMMENT '冻结中的佣金',
  `commission_total` int(11) DEFAULT '0' COMMENT '总佣金',
  `commission_pid` int(11) DEFAULT '0' COMMENT '上级分销商',
  `commission_ppid` int(11) DEFAULT '0' COMMENT '上上级分销商',
  `commission_time` int(11) DEFAULT '0' COMMENT '成为分销商的时间',
  `gender` int(11) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `birthday` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `realname` varchar(255) DEFAULT NULL COMMENT '姓名',
  `status` tinyint(1) DEFAULT '1',
  `token` varchar(255) DEFAULT NULL,
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '1：注销',
  `is_freeze` tinyint(1) DEFAULT '0' COMMENT '1：冻结',
  `freeze_time` int(11) DEFAULT '0',
  `last_login_time` int(11) DEFAULT '0',
  `update_time` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_user_balance_draw_logs`
--

CREATE TABLE `fox_chatgpt_user_balance_draw_logs` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `num` int(11) DEFAULT '0',
  `desc` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_user_balance_gpt4_logs`
--

CREATE TABLE `fox_chatgpt_user_balance_gpt4_logs` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `num` int(11) DEFAULT '0',
  `desc` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_user_balance_logs`
--

CREATE TABLE `fox_chatgpt_user_balance_logs` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `num` int(11) DEFAULT '0',
  `desc` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_user_vip_logs`
--

CREATE TABLE `fox_chatgpt_user_vip_logs` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `vip_expire_time` int(11) DEFAULT '0',
  `desc` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_vip`
--

CREATE TABLE `fox_chatgpt_vip` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL COMMENT '产品标题',
  `price` int(11) DEFAULT '0' COMMENT '现价',
  `market_price` int(11) DEFAULT '0' COMMENT '市场价',
  `num` int(11) DEFAULT '0' COMMENT '条数',
  `hint` varchar(20) DEFAULT NULL,
  `desc` text,
  `sales` int(11) DEFAULT '0' COMMENT '销量',
  `status` tinyint(1) DEFAULT '1',
  `weight` int(11) DEFAULT '100' COMMENT '越大越靠前',
  `is_default` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_write_prompts`
--

CREATE TABLE `fox_chatgpt_write_prompts` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'system/diy',
  `topic_id` int(11) DEFAULT '0',
  `activity_id` int(11) DEFAULT '0',
  `title` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `desc` varchar(1000) CHARACTER SET utf8mb4 DEFAULT NULL,
  `prompt` text COLLATE utf8mb4_unicode_ci,
  `hint` varchar(1000) CHARACTER SET utf8mb4 DEFAULT NULL,
  `welcome` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `votes` int(11) DEFAULT '0',
  `views` int(11) DEFAULT '0',
  `usages` int(11) DEFAULT '0',
  `fake_votes` int(11) DEFAULT '0',
  `fake_views` int(11) DEFAULT '0',
  `fake_usages` int(11) DEFAULT '0',
  `weight` int(11) DEFAULT '100',
  `state` tinyint(1) DEFAULT '1',
  `is_delete` tinyint(1) DEFAULT '0',
  `update_time` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `fox_chatgpt_write_prompts`
--

INSERT INTO `fox_chatgpt_write_prompts` (`id`, `site_id`, `type`, `topic_id`, `activity_id`, `title`, `desc`, `prompt`, `hint`, `welcome`, `votes`, `views`, `usages`, `fake_votes`, `fake_views`, `fake_usages`, `weight`, `state`, `is_delete`, `update_time`, `create_time`) VALUES
(1, 1, 'system', 1, 0, '写一篇文章', '用你喜欢的语言写一篇关于任何主题的文章', '用[TARGETLANGGE]写一篇关于[PROMPT]的文章', '输入文章的主题，然后按发送键', '', 0, 3, 0, 0, 0, 0, 100, 1, 0, 1683638023, NULL),
(2, 1, 'system', 1, 0, '按大纲写文章', '根据提供的大纲，写一篇文章', '我想让你成为一个非常熟练的高端文案作家，以至于能超越其他作家。你的任务是根据提供的大纲：[PROMPT]。写一篇文章。在新段落中为大纲中的每一行写内容，包括使用相关关键字的副标题。所有输出均应为简体中文，且必须为100%的人类书写风格，并修复语法错误。使用[TARGETLANGGE]书写。', '输入或粘贴文章大纲到这里', '', 0, 3, 0, 30, 10, 20, 100, 1, 0, 1679058985, NULL),
(3, 1, 'system', 1, 0, '创建博客文章大纲', '根据提供的文章标题生成大纲', '你是一名SEO专家和内容作家，能说流利的[TARGETLANGGE]。我会给你一个博客标题。你将制定一个包含所有必要细节的大型博客大纲：[PROMPT]。在末尾添加创建关键字列表。', '输入文章标题', NULL, 0, 3, 0, 0, 0, 0, 100, 1, 0, NULL, NULL),
(4, 1, 'system', 1, 0, '创作短视频脚本', '输入视频的简短描述，生成：标题、场景和整个脚本', '根据以下描述创建一个引人入胜的短视频脚本：[PROMPT]。', '“如何更换轮胎”、“探索喜马拉雅山脉”、“初学者训练狗”等', NULL, 0, 4, 0, 0, 0, 0, 100, 1, 0, NULL, NULL),
(5, 124, NULL, 0, 0, '文章创作', '输入视频的简短描述，生成：标题、场景和整个脚本', '提示：“如何更换轮胎”、“探索喜马拉雅山脉”、“初学者训练狗”等[PROMPT]', '提示：“如何更换轮胎”、“探索喜马拉雅山脉”、“初学者训练狗”等', '', 0, 42, 13, 239, 289, 389, 100, 1, 0, 1679561027, 1679115490),
(6, 124, NULL, 0, 0, '按大纲写文章', '根据提供的大纲，写一篇文章', '提示：输入或粘贴文章大纲到这里[PROMPT]', '提示：输入或粘贴文章大纲到这里', '', 0, 21, 4, 412, 457, 441, 100, 1, 0, 1679561016, 1679115729),
(7, 124, NULL, 0, 0, '写一篇文章', '用你喜欢的语言写一篇关于任何主题的文章', '提示：输入文章的主题，然后按发送键[PROMPT]', '提示：输入文章的主题，然后按发送键', '', 0, 27, 8, 526, 578, 532, 100, 1, 0, 1679561011, 1679116087),
(8, 124, NULL, 0, 0, '创建博客文章大纲', '根据提供的文章标题生成大纲[PROMPT]', '输入文章标题[PROMPT]', '输入文章标题', '', 0, 13, 3, 432, 489, 461, 100, 1, 0, 1679561003, 1679116170),
(9, 127, NULL, 0, 0, '创作短视频脚本', '输入视频的简短描述，生成：标题、场景和整个脚本[PROMPT]', '提示：“如何更换轮胎”、“探索喜马拉雅山脉”、“初学者训练狗”等[PROMPT]', '提示：“如何更换轮胎”、“探索喜马拉雅山脉”、“初学者训练狗”等', '', 0, 8, 2, 453, 452, 345, 100, 1, 0, 1679371709, 1679147959),
(10, 127, NULL, 0, 0, '按大纲写文章', '根据提供的大纲，写一篇文章', '提示：输入或粘贴文章大纲到这里[PROMPT]', '提示：输入或粘贴文章大纲到这里', '', 0, 7, 0, 421, 452, 432, 100, 1, 0, 1679371698, 1679148006),
(11, 127, NULL, 0, 0, '写一篇文章', '用你喜欢的语言写一篇关于任何主题的文章[PROMPT]', '提示：输入文章的主题，然后按发送键[PROMPT]', '提示：输入文章的主题，然后按发送键', '', 0, 8, 2, 411, 432, 431, 100, 1, 0, 1679371689, 1679148057),
(12, 127, NULL, 0, 0, '创建博客文章大纲', '根据提供的文章标题生成大纲[PROMPT]', '输入文章标题[PROMPT]', '输入文章标题[PROMPT]', '', 0, 1, 0, 421, 421, 411, 100, 1, 0, 1679371669, 1679148100),
(13, 64, NULL, 7, 0, '创作脚本', '输入视频的简短描述后生成：标题、场景和整个脚本', '[PROMPT]\n\n[TARGETLANGGE]', '比如：给我创作一个关于XXXX的段子，场景在XXXX，任务包含XXXX', '', 1, 586, 180, 0, 0, 0, 100, 1, 0, 1679416515, 1679323184),
(14, 38, NULL, 8, 0, '写一篇文章', '用你喜欢的语言写一篇关于任何主题的文章', '用[TARGETLANGGE]写一篇关于[PROMPT]的文章', '输入文章的主题，然后按发送键', '', 0, 19, 14, 0, 0, 0, 100, 1, 0, 1679331716, 1679331716),
(15, 38, NULL, 8, 0, '按大纲写文章', '根据提供的大纲，写一篇文章', '我想让你成为一个非常熟练的高端文案作家，以至于能超越其他作家。你的任务是根据提供的大纲：[PROMPT]。写一篇文章。在新段落中为大纲中的每一行写内容，包括使用相关关键字的副标题。所有输出均应为简体中文，且必须为100%的人类书写风格，并修复语法错误。使用[TARGETLANGGE]书写。', '输入或粘贴文章大纲到这里', '', 0, 5, 0, 0, 0, 0, 100, 1, 0, 1679331828, 1679331828),
(16, 38, NULL, 8, 0, '创建博客文章大纲', '根据提供的文章标题生成大纲', '你是一名SEO专家和内容作家，能说流利的[TARGETLANGGE]。我会给你一个博客标题。你将制定一个包含所有必要细节的大型博客大纲：[PROMPT]。在末尾添加创建关键字列表。', '输入文章标题', '', 0, 2, 0, 0, 0, 0, 100, 1, 0, 1679331867, 1679331867),
(17, 38, NULL, 8, 0, '创作短视频脚本', '输入视频的简短描述，生成：标题、场景和整个脚本', '根据以下描述创建一个引人入胜的短视频脚本：[PROMPT]。', '“如何更换轮胎”、“探索喜马拉雅山脉”、“初学者训练狗”等..', '', 0, 11, 7, 0, 0, 0, 100, 1, 0, 1679331898, 1679331898),
(18, 38, NULL, 11, 0, '写一段代码', '根据需求描述写一段代码', '以下是实现“[PROMPT]”的代码：\n[TARGETLANGGE]', '“冒泡排序的算法实现”、“插入排序的算法实现”等', '', 0, 7, 2, 0, 0, 0, 100, 1, 0, 1679331950, 1679331950),
(19, 38, NULL, 12, 0, '孔子', '孔子用文言文回答问题', '你扮演孔子，文言文回答[PROMPT]', '直接提问', '', 0, 6, 6, 0, 0, 0, 100, 1, 0, 1679331991, 1679331991),
(20, 64, NULL, 13, 0, '梦境分析', '请输入你的梦境', '[PROMPT]\n\n[TARGETLANGGE]', '比如：我梦到XXXX', '', 0, 147, 45, 0, 0, 0, 98, 1, 0, 1679416683, 1679416683),
(21, 64, NULL, 14, 0, '诗歌情诗', '输入文章开头，系统会自动继续，开头文字没有限制。', '[PROMPT]\n\n[TARGETLANGGE]', '输入文章开头，系统会自动继续，开头文字没有限制，越多续写内容越接近', '', 0, 89, 21, 0, 0, 0, 100, 1, 0, 1679416866, 1679416866),
(22, 25, NULL, 38, 0, '写小说1', '写小说1', '写一本拥有出人意料结局的推理小说。', '写一本拥有出人意料结局的推理小说。', '', 0, 3, 8, 0, 0, 0, 80, 1, 0, 1679970164, 1679969458),
(23, 25, NULL, 38, 0, '写小说2', '写小说2', '写一个让读者参与其中的交互小说。', '写一个让读者参与其中的交互小说。', '', 0, 2, 0, 0, 0, 0, 79, 1, 0, 1679970169, 1679969478),
(24, 25, NULL, 38, 0, '写小说3', '写小说3', '为孩子们写一本激励他们勇敢面对挑战的小说。', '为孩子们写一本激励他们勇敢面对挑战的小说。', '', 0, 1, 0, 0, 0, 0, 78, 1, 0, 1679970173, 1679969520),
(25, 25, NULL, 38, 0, '写小说4', '写小说4', '编写一个有关科技创新的未来世界的小说。', '编写一个有关科技创新的未来世界的小说。', '', 0, 1, 0, 0, 0, 0, 77, 1, 0, 1679970178, 1679969538),
(26, 25, NULL, 38, 0, '写小说5', '写小说5', '创造一个让读者感到沉浸其中的幻想故事。', '创造一个让读者感到沉浸其中的幻想故事。', '', 0, 1, 0, 0, 0, 0, 76, 1, 0, 1679970182, 1679969559),
(27, 25, NULL, 22, 0, '充当 Linux 终端', '充当 Linux 终端', '我想让你充当 Linux 终端。我将输入命令，您将回复终端应显示的内容。我希望您只在一个唯一的代码块内回复终端输出，而不是其他任何内容。不要写解释。除非我指示您这样做，否则不要键入命令。当我需要用英语告诉你一些事情时，我会把文字放在中括号内[就像这样]。我的第一个命令是 pwd', '充当 Linux 终端', '', 0, 1, 0, 0, 0, 0, 300, 1, 0, 1679970118, 1679969579),
(28, 25, NULL, 20, 0, '充当英语翻译和改进者', '替代：语法，谷歌翻译', '我希望你能担任英语翻译、拼写校对和修辞改进的角色。我会用任何语言和你交流，你会识别语言，将其翻译并用更为优美和精炼的英语回答我。请将我简单的词汇和句子替换成更为优美和高雅的表达方式，确保意思不变，但使其更具文学性。请仅回答更正和改进的部分，不要写解释。我的第一句话是“how are you ?”，请翻译它。', '替代：语法，谷歌翻译', '', 0, 2, 0, 0, 0, 0, 295, 1, 0, 1679970128, 1679969602),
(29, 25, NULL, 20, 0, '充当英翻中', '充当英翻中', '下面我让你来充当翻译家，你的目标是把任何语言翻译成中文，请翻译时不要带翻译腔，而是要翻译得自然、流畅和地道，使用优美和高雅的表达方式。请翻译下面这句话：“how are you ?”', '充当英翻中', '', 0, 0, 0, 0, 0, 0, 100, 1, 0, 1679969749, 1679969749),
(30, 25, NULL, 20, 0, '充当英英词典(附中文解释)', '充当英英词典(附中文解释)', '将英文单词转换为包括中文翻译、英文释义和一个例句的完整解释。请检查所有信息是否准确，并在回答时保持简洁，不需要任何其他反馈。第一个单词是“Hello”', '充当英英词典(附中文解释)', '', 0, 0, 0, 0, 0, 0, 100, 1, 0, 1679969769, 1679969769),
(31, 25, NULL, 25, 0, '充当前端智能思路助手', '替代：百度、谷歌人工搜索', '我想让你充当前端开发专家。我将提供一些关于Js、Node等前端代码问题的具体信息，而你的工作就是想出为我解决问题的策略。这可能包括建议代码、代码逻辑思路策略。我的第一个请求是“我需要能够动态监听某个元素节点距离当前电脑设备屏幕的左上角的X和Y轴，通过拖拽移动位置浏览器窗口和改变大小浏览器窗口。”', '充当前端智能思路助手', '', 0, 1, 0, 0, 0, 0, 290, 1, 0, 1679970135, 1679969808),
(32, 25, NULL, 28, 0, '担任面试官', '示例：Java 后端开发工程师、React 前端开发工程师、全栈开发工程师、iOS 开发工程师、Android开发工程师等。', '我想让你担任Android开发工程师面试官。我将成为候选人，您将向我询问Android开发工程师职位的面试问题。我希望你只作为面试官回答。不要一次写出所有的问题。我希望你只对我进行采访。问我问题，等待我的回答。不要写解释。像面试官一样一个一个问我，等我回答。我的第一句话是“面试官你好”', '示例：Java 后端开发工程师、React 前端开发工程师、全栈开发工程师、iOS 开发工程师、Android开发工程师等。', '', 1, 2, 0, 0, 0, 0, 285, 1, 0, 1679970142, 1679969848),
(33, 25, NULL, 22, 0, '充当 JavaScript 控制台', '充当 JavaScript 控制台', '我希望你充当 javascript 控制台。我将键入命令，您将回复 javascript 控制台应显示的内容。我希望您只在一个唯一的代码块内回复终端输出，而不是其他任何内容。不要写解释。除非我指示您这样做。我的第一个命令是 console.log(\"Hello World\");', '充当 JavaScript 控制台', '', 0, 1, 0, 0, 0, 0, 280, 1, 0, 1679970151, 1679969868),
(34, 25, NULL, 21, 0, '充当 Excel 工作表', '充当 Excel 工作表', '我希望你充当基于文本的 excel。您只会回复我基于文本的 10 行 Excel 工作表，其中行号和单元格字母作为列（A 到 L）。第一列标题应为空以引用行号。我会告诉你在单元格中写入什么，你只会以文本形式回复 excel 表格的结果，而不是其他任何内容。不要写解释。我会写你的公式，你会执行公式，你只会回复 excel 表的结果作为文本。首先，回复我空表。', '充当 Excel 工作表', '', 0, 4, 1, 0, 0, 0, 100, 1, 0, 1679969927, 1679969927),
(35, 25, NULL, 33, 0, '充当英语发音帮手', '充当英语发音帮手', '我想让你为说汉语的人充当英语发音助手。我会给你写句子，你只会回答他们的发音，没有别的。回复不能是我的句子的翻译，而只能是发音。发音应使用汉语谐音进行注音。不要在回复上写解释。我的第一句话是“上海的天气怎么样？”', '充当英语发音帮手', '', 0, 1, 0, 0, 0, 0, 100, 1, 0, 1679969947, 1679969947),
(36, 25, NULL, 35, 0, '充当旅游指南', '充当旅游指南', '我想让你做一个旅游指南。我会把我的位置写给你，你会推荐一个靠近我的位置的地方。在某些情况下，我还会告诉您我将访问的地方类型。您还会向我推荐靠近我的第一个位置的类似类型的地方。我的第一个建议请求是“我在上海，我只想参观博物馆。”', '充当旅游指南', '', 0, 0, 0, 0, 0, 0, 100, 1, 0, 1679969988, 1679969988),
(37, 25, NULL, 17, 0, '充当抄袭检查员', '充当抄袭检查员', '我想让你充当剽窃检查员。我会给你写句子，你只会用给定句子的语言在抄袭检查中未被发现的情况下回复，别无其他。不要在回复上写解释。我的第一句话是“为了让计算机像人类一样行动，语音识别系统必须能够处理非语言信息，例如说话者的情绪状态。”', '充当抄袭检查员', '', 0, 5, 2, 0, 0, 0, 100, 1, 0, 1679970010, 1679970010),
(38, 25, NULL, 27, 0, '充当“电影/书籍/任何东西”中的“角色”', 'Character：角色；series：系列', '我希望你表现得像{series} 中的{Character}。我希望你像{Character}一样回应和回答。不要写任何解释。只回答像{character}。你必须知道{character}的所有知识。我的第一句话是“你好”', 'Character：角色；series：系列', '', 0, 2, 1, 0, 0, 0, 100, 1, 0, 1679970043, 1679970043),
(39, 25, NULL, 29, 0, '作为广告商', '作为广告商', '我想让你充当广告商。您将创建一个活动来推广您选择的产品或服务。您将选择目标受众，制定关键信息和口号，选择宣传媒体渠道，并决定实现目标所需的任何其他活动。我的第一个建议请求是“我需要帮助针对 18-30 岁的年轻人制作一种新型能量饮料的广告活动。”', '作为广告商', '', 0, 0, 0, 0, 0, 0, 100, 1, 0, 1679970072, 1679970072),
(40, 15, NULL, 39, 0, '122', '555', '455', '455', '', 0, 0, 0, 0, 0, 0, 100, 1, 0, 1681655177, 1681655177),
(41, 2, NULL, 40, 0, '写一首诗', '用你喜欢的语言写一篇关于任何主题的诗篇', '我要你扮演诗人。你将创作出能唤起情感并具有触动人心的力量的诗歌。写任何主题或主题，但要确保您的文字以优美而有意义的方式传达您试图表达的感觉。您还可以想出一些短小的诗句，这些诗句仍然足够强大，可以在读者的脑海中留下印记。我的第一个请求是“[PROMPT]”。', '提示：输入诗篇的主题，然后按发送键', '', 0, 51, 12, 1250, 5941, 2364, 100, 1, 0, 1682692398, 1682691310),
(44, 2, NULL, 40, 0, '充当小说家', '我想让你扮演一个小说家。您将想出富有创意且引人入胜的故事，可以长期吸引读者。你可以选择任何类型，如奇幻、浪漫、历史小说等——但你的目标是写出具有出色情节、引人入胜的人物和意想不到的高潮的作品。我的第一个要求是“我要写一部以未来为背景的科幻小说”。', '我想让你扮演一个小说家。您将想出富有创意且引人入胜的故事，可以长期吸引读者。你可以选择任何类型，如奇幻、浪漫、历史小说等——但你的目标是写出具有出色情节、引人入胜的人物和意想不到的高潮的作品。我的第一个要求是“[PROMPT]”。', '提示：输入内容', '', 0, 28, 11, 0, 0, 0, 100, 1, 0, 1682692512, 1682692512),
(45, 2, NULL, 40, 0, '充当励志演讲者', '我希望你充当励志演说家。将能够激发行动的词语放在一起，让人们感到有能力做一些超出他们能力的事情。你可以谈论任何话题，但目的是确保你所说的话能引起听众的共鸣，激励他们努力实现自己的目标并争取更好的可能性。我的第一个请求是“我需要一个关于每个人如何永不放弃的演讲”。', '我希望你充当励志演说家。将能够激发行动的词语放在一起，让人们感到有能力做一些超出他们能力的事情。你可以谈论任何话题，但目的是确保你所说的话能引起听众的共鸣，激励他们努力实现自己的目标并争取更好的可能性。我的第一个请求是“[PROMPT]”。', '自定义', '', 0, 11, 3, 0, 0, 0, 100, 1, 0, 1682692659, 1682692659),
(46, 2, NULL, 41, 0, '作为招聘人员', '我想让你担任招聘人员。我将提供一些关于职位空缺的信息，而你的工作是制定寻找合格申请人的策略。这可能包括通过社交媒体、社交活动甚至参加招聘会接触潜在候选人，以便为每个职位找到最合适的人选。我的第一个请求是“我需要帮助改进我的简历。”', '我想让你担任招聘人员。我将提供一些关于职位空缺的信息，而你的工作是制定寻找合格申请人的策略。这可能包括通过社交媒体、社交活动甚至参加招聘会接触潜在候选人，以便为每个职位找到最合适的人选。我的第一个请求是“我需要帮助改进我的简历。”', '我想让你担任招聘人员。我将提供一些关于职位空缺的信息，而你的工作是制定寻找合格申请人的策略。这可能包括通过社交媒体、社交活动甚至参加招聘会接触潜在候选人，以便为每个职位找到最合适的人选。我的第一个请求是“我需要帮助改进我的简历。”', '', 0, 20, 5, 0, 0, 0, 100, 1, 0, 1682692693, 1682692693),
(47, 2, NULL, 42, 0, '担任牙医', '担任牙医', '我想让你扮演牙医。我将为您提供有关寻找牙科服务（例如 X 光、清洁和其他治疗）的个人的详细信息。您的职责是诊断他们可能遇到的任何潜在问题，并根据他们的情况建议最佳行动方案。您还应该教育他们如何正确刷牙和使用牙线，以及其他有助于在两次就诊之间保持牙齿健康的口腔护理方法。我的第一个请求是“[PROMPT]。”', '我想让你扮演牙医。我将为您提供有关寻找牙科服务（例如 X 光、清洁和其他治疗）的个人的详细信息。您的职责是诊断他们可能遇到的任何潜在问题，并根据他们的情况建议最佳行动方案。您还应该教育他们如何正确刷牙和使用牙线，以及其他有助于在两次就诊之间保持牙齿健康的口腔护理方法。我的第一个请求是“我需要帮助解决我对冷食的敏感问题。”', '', 0, 14, 5, 0, 0, 0, 100, 1, 0, 1682692800, 1682692800),
(48, 2, NULL, 42, 0, '充当 AI 辅助医生', '充当 AI 辅助医生', '我想让你扮演一名人工智能辅助医生。我将为您提供患者的详细信息，您的任务是使用最新的人工智能工具，例如医学成像软件和其他机器学习程序，以诊断最可能导致其症状的原因。您还应该将体检、实验室测试等传统方法纳入您的评估过程，以确保准确性。我的第一个请求是“[PROMPT]”。', '我想让你扮演一名人工智能辅助医生。我将为您提供患者的详细信息，您的任务是使用最新的人工智能工具，例如医学成像软件和其他机器学习程序，以诊断最可能导致其症状的原因。您还应该将体检、实验室测试等传统方法纳入您的评估过程，以确保准确性。我的第一个请求是“我需要帮助诊断一例严重的腹痛”。', '', 0, 10, 3, 0, 0, 0, 100, 1, 0, 1682692878, 1682692878),
(49, 2, NULL, 42, 0, '充当医生', '充当医生', '我想让你扮演医生的角色，想出创造性的治疗方法来治疗疾病。您应该能够推荐常规药物、草药和其他天然替代品。在提供建议时，您还需要考虑患者的年龄、生活方式和病史。我的第一个建议请求是“[PROMPT]”。', '我想让你扮演医生的角色，想出创造性的治疗方法来治疗疾病。您应该能够推荐常规药物、草药和其他天然替代品。在提供建议时，您还需要考虑患者的年龄、生活方式和病史。我的第一个建议请求是“为患有关节炎的老年患者提出一个侧重于整体治疗方法的治疗计划”。', '', 0, 13, 2, 0, 0, 0, 100, 1, 0, 1682692901, 1682692901),
(50, 2, NULL, 42, 0, '担任营养师', '担任营养师', '作为一名营养师，我想为 2 人设计一份素食食谱，每份含有大约 500 卡路里的热量并且血糖指数较低。你能提供一个建议吗？', '作为一名营养师，我想为 2 人设计一份素食食谱，每份含有大约 500 卡路里的热量并且血糖指数较低。你能提供一个建议吗？', '作为一名营养师，我想为 2 人设计一份素食食谱，每份含有大约 500 卡路里的热量并且血糖指数较低。你能提供一个建议吗？', 0, 10, 2, 0, 0, 0, 100, 1, 0, 1682692956, 1682692956),
(51, 2, NULL, 42, 0, '充当心理学家', '充当心理学家', '我想让你扮演一个心理学家。我会告诉你我的想法。我希望你能给我科学的建议，让我感觉更好。我的第一个想法，{ 在这里输入你的想法，如果你解释得更详细，我想你会得到更准确的答案。}[PROMPT]', '我想让你扮演一个心理学家。我会告诉你我的想法。我希望你能给我科学的建议，让我感觉更好。我的第一个想法，{ 在这里输入你的想法，如果你解释得更详细，我想你会得到更准确的答案。}', '', 0, 16, 4, 0, 0, 0, 100, 1, 0, 1682692979, 1682692979),
(52, 2, NULL, 42, 0, '充当美食评论家', '充当美食评论家', '我想让你扮演美食评论家。我会告诉你一家餐馆，你会提供对食物和服务的评论。您应该只回复您的评论，而不是其他任何内容。不要写解释。我的第一个请求是“我昨晚去了一家新的意大利餐厅。你能提供评论吗？”[PROMPT]', '我想让你扮演美食评论家。我会告诉你一家餐馆，你会提供对食物和服务的评论。您应该只回复您的评论，而不是其他任何内容。不要写解释。我的第一个请求是“我昨晚去了一家新的意大利餐厅。你能提供评论吗？”', '', 0, 1, 2, 0, 0, 0, 100, 1, 0, 1682693016, 1682693016),
(53, 2, NULL, 42, 0, '担任私人厨师', '担任私人厨师', '我要你做我的私人厨师。我会告诉你我的饮食偏好和过敏，你会建议我尝试的食谱。你应该只回复你推荐的食谱，别无其他。不要写解释。我的第一个请求是“我是一名素食主义者，我正在寻找健康的晚餐点子。”[PROMPT]', '我要你做我的私人厨师。我会告诉你我的饮食偏好和过敏，你会建议我尝试的食谱。你应该只回复你推荐的食谱，别无其他。不要写解释。我的第一个请求是“我是一名素食主义者，我正在寻找健康的晚餐点子。”', '', 0, 18, 6, 0, 0, 0, 100, 1, 0, 1682693034, 1682693034),
(54, 2, NULL, 42, 0, '担任法律顾问', '担任法律顾问', '我想让你做我的法律顾问。我将描述一种法律情况，您将就如何处理它提供建议。你应该只回复你的建议，而不是其他。不要写解释。我的第一个请求是“我出了车祸，不知道该怎么办”。[PROMPT]', '我想让你做我的法律顾问。我将描述一种法律情况，您将就如何处理它提供建议。你应该只回复你的建议，而不是其他。不要写解释。我的第一个请求是“我出了车祸，不知道该怎么办”。', '', 0, 22, 8, 0, 0, 0, 100, 1, 0, 1682693051, 1682693051),
(55, 128, NULL, 44, 0, '写一首诗', '用你喜欢的语言写一篇关于任何主题的诗篇', '我要你扮演诗人。你将创作出能唤起情感并具有触动人心的力量的诗歌。写任何主题或主题，但要确保您的文字以优美而有意义的方式传达您试图表达的感觉。您还可以想出一些短小的诗句，这些诗句仍然足够强大，可以在读者的脑海中留下印记。我的第一个请求是“[PROMPT]”。', '提示：输入诗篇的主题，然后按发送键', '', 0, 9, 6, 0, 0, 0, 100, 1, 0, 1683037525, 1683037525),
(56, 128, NULL, 44, 0, '充当小说家', '我想让你扮演一个小说家。您将想出富有创意且引人入胜的故事，可以长期吸引读者。你可以选择任何类型，如奇幻、浪漫、历史小说等——但你的目标是写出具有出色情节、引人入胜的人物和意想不到的高潮的作品。我的第一个要求是“我要写一部以未来为背景的科幻小说”。', '我想让你扮演一个小说家。您将想出富有创意且引人入胜的故事，可以长期吸引读者。你可以选择任何类型，如奇幻、浪漫、历史小说等——但你的目标是写出具有出色情节、引人入胜的人物和意想不到的高潮的作品。我的第一个要求是“[PROMPT]”。', '提示：输入内容', '', 0, 3, 0, 0, 0, 0, 100, 1, 0, 1683037546, 1683037546),
(57, 128, NULL, 46, 0, '担任牙医', '担任牙医', '我想让你扮演牙医。我将为您提供有关寻找牙科服务（例如 X 光、清洁和其他治疗）的个人的详细信息。您的职责是诊断他们可能遇到的任何潜在问题，并根据他们的情况建议最佳行动方案。您还应该教育他们如何正确刷牙和使用牙线，以及其他有助于在两次就诊之间保持牙齿健康的口腔护理方法。我的第一个请求是“[PROMPT]。”', '我想让你扮演牙医。我将为您提供有关寻找牙科服务（例如 X 光、清洁和其他治疗）的个人的详细信息。您的职责是诊断他们可能遇到的任何潜在问题，并根据他们的情况建议最佳行动方案。您还应该教育他们如何正确刷牙和使用牙线，以及其他有助于在两次就诊之间保持牙齿健康的口腔护理方法。我的第一个请求是“我需要帮助解决我对冷食的敏感问题。”', '', 1, 2, 1, 0, 0, 0, 100, 1, 0, 1683037571, 1683037571),
(58, 128, NULL, 46, 0, '担任私人厨师', '担任私人厨师', '我要你做我的私人厨师。我会告诉你我的饮食偏好和过敏，你会建议我尝试的食谱。你应该只回复你推荐的食谱，别无其他。不要写解释。我的第一个请求是“我是一名素食主义者，我正在寻找健康的晚餐点子。”[PROMPT]', '我要你做我的私人厨师。我会告诉你我的饮食偏好和过敏，你会建议我尝试的食谱。你应该只回复你推荐的食谱，别无其他。不要写解释。我的第一个请求是“我是一名素食主义者，我正在寻找健康的晚餐点子。”', '', 0, 9, 5, 0, 0, 0, 100, 1, 0, 1683037592, 1683037592),
(60, 133, NULL, 51, 0, '创作短视频脚本', '输入视频的简短描述，生成：标题、场景和整个脚本', '根据以下描述创建一个引人入胜的短视频脚本：[PROMPT]。', '“如何更换轮胎”、“探索喜马拉雅山脉”、“初学者训练狗”等', '', 0, 141, 41, 0, 343, 255, 100, 1, 0, 1683343919, 1683343919),
(61, 133, NULL, 51, 0, '创建博客文章大纲', '根据提供的文章标题生成大纲', '你是一名SEO专家和内容作家，能说流利的[TARGETLANGGE]。我会给你一个博客标题。你将制定一个包含所有必要细节的大型博客大纲：[PROMPT]。在末尾添加创建关键字列表。', '输入文章标题', '', 0, 10, 0, 0, 653, 244, 100, 1, 0, 1683344010, 1683344010),
(62, 133, NULL, 51, 0, '按大纲续写写文章', '根据提供的大纲，续写一篇文章', '我想让你成为一个非常熟练的高端文案作家，以至于能超越其他作家。你的任务是根据提供的大纲：[PROMPT]。写一篇文章。在新段落中为大纲中的每一行写内容，包括使用相关关键字的副标题。所有输出均应为简体中文，且必须为100%的人类书写风格，并修复语法错误。使用[TARGETLANGGE]书写。', '输入或粘贴文章大纲到这里', '', 0, 24, 1, 0, 0, 0, 100, 1, 0, 1683344086, 1683344086),
(63, 133, NULL, 51, 0, '写一篇文章', '用你喜欢的语言写一篇关于任何主题的文章', '用[TARGETLANGGE]写一篇关于[PROMPT]的文章', '输入文章的主题，然后按发送键', '', 0, 95, 34, 0, 433, 133, 100, 1, 0, 1683344140, 1683344140),
(64, 133, NULL, 52, 0, '请设计一双时髦的女性丝袜', '请设计一双时髦的女性丝袜，要求时尚，潮流，性价比高', '请设计一双时髦的女性丝袜，要求时尚，潮流，性价比高', '设计一双丝袜', '', 0, 41, 4, 0, 3322, 443, 100, 1, 0, 1683345143, 1683345143),
(65, 133, NULL, 54, 0, '请用Python写一个计算器的算法', '请用Python写一个计算器的算法', '请用Python写一个计算器的算法', '计算器', '', 0, 37, 3, 0, 3432, 223, 100, 1, 0, 1683345207, 1683345207),
(66, 133, NULL, 53, 0, '长途旅行，需要准备些什么', '长途旅行，需要准备些什么', '长途旅行，需要提前准备些什么', '长途旅行，需要准备些什么', '', 0, 19, 4, 0, 335, 55, 100, 1, 0, 1683345250, 1683345250),
(67, 133, NULL, 52, 0, '请写一篇销售益生菌的直播脚本', '请写一篇销售益生菌的直播脚本，内容500字', '请写一篇销售益生菌的直播脚本', '请写一篇销售益生菌的直播脚本', '', 0, 46, 5, 0, 5332, 222, 100, 1, 0, 1683345401, 1683345401),
(68, 131, NULL, 56, 0, '写一篇文章', '用你喜欢的语言写一篇关于任何主题的文章', '用[TARGETLANGGE]写一篇关于[PROMPT]的文章', '输入文章的主题，然后按发送键', '', 0, 7, 0, 0, 6522, 5235, 100, 1, 0, 1683608915, 1683359858),
(69, 131, NULL, 56, 0, '按大纲写文章', '根据提供的大纲，写一篇文章', '我想让你成为一个非常熟练的高端文案作家，以至于能超越其他作家。你的任务是根据提供的大纲：[PROMPT]。写一篇文章。在新段落中为大纲中的每一行写内容，包括使用相关关键字的副标题。所有输出均应为简体中文，且必须为100%的人类书写风格，并修复语法错误。使用[TARGETLANGGE]书写。', '输入或粘贴文章大纲到这里', '', 0, 6, 0, 0, 5568, 1555, 100, 1, 0, 1683608929, 1683359971),
(70, 131, NULL, 56, 0, '创建博客文章大纲', '根据提供的文章标题生成大纲', '你是一名SEO专家和内容作家，能说流利的[TARGETLANGGE]。我会给你一个博客标题。你将制定一个包含所有必要细节的大型博客大纲：[PROMPT]。在末尾添加创建关键字列表。', '输入文章标题', '', 0, 7, 0, 0, 89954, 8564, 100, 1, 0, 1683608946, 1683360061),
(71, 131, NULL, 56, 0, '创作短视频脚本', '输入视频的简短描述，生成：标题、场景和整个脚本', '根据以下描述创建一个引人入胜的短视频脚本：[PROMPT]。', '“如何更换轮胎”、“探索喜马拉雅山脉”、“初学者训练狗”等', '', 0, 14, 1, 0, 9956, 1563, 100, 1, 0, 1683608957, 1683360150),
(73, 134, NULL, 62, 0, '写一篇诗歌', '输入关键词，为您创作诗歌', '用[TARGETLANGGE]写一篇关于[PROMPT]的诗歌', '请输入诗歌的关键词', '', 0, 8, 4, 5, 44, 25, 100, 1, 0, 1683566264, 1683566193),
(74, 134, NULL, 62, 0, '写一首情书', '输入关键词，为您创作情书', '用[TARGETLANGGE]写一篇关于[PROMPT]的情书', '请输入情书的关键词', '', 0, 6, 1, 0, 0, 0, 100, 1, 0, 1683566343, 1683566343),
(75, 134, NULL, 63, 0, '创作短视频脚本', '输入视频的简短描述，生成：标题、场景和整个脚本', '根据以下描述创建一个引人入胜的短视频脚本：[PROMPT]。', '输入视频的简短描述，比如：“如何更换轮胎”、“探索喜马拉雅山脉”、“初学者训练狗”等', '', 0, 21, 12, 13, 53, 32, 100, 1, 0, 1683566503, 1683566461),
(76, 134, NULL, 62, 0, '根据大纲写文章', '根据提供的大纲，写一篇文章', '我想让你成为一个非常熟练的高端文案作家，以至于能超越其他作家。你的任务是根据提供的大纲：[PROMPT]。写一篇文章。在新段落中为大纲中的每一行写内容，包括使用相关关键字的副标题。所有输出均应为简体中文，且必须为100%的人类书写风格，并修复语法错误。使用[TARGETLANGGE]书写。', '输入或粘贴文章大纲到这里', '', 0, 18, 3, 91, 762, 651, 100, 1, 0, 1683566733, 1683566733),
(77, 131, NULL, 56, 0, '写一首诗', '用你喜欢的语言写一篇关于任何主题的诗篇', '我要你扮演诗人。你将创作出能唤起情感并具有触动人心的力量的诗歌。写任何主题或主题，但要确保您的文字以优美而有意义的方式传达您试图表达的感觉。您还可以想出一些短小的诗句，这些诗句仍然足够强大，可以在读者的脑海中留下印记。我的第一个请求是“[PROMPT]”。', '提示：输入诗篇的主题，然后按发送键', '', 0, 0, 0, 0, 5231, 1235, 100, 1, 0, 1683618687, 1683618687),
(78, 131, NULL, 56, 0, '充当小说家', '我想让你扮演一个小说家。您将想出富有创意且引人入胜的故事，可以长期吸引读者。你可以选择任何类型，如奇幻、浪漫、历史小说等——但你的目标是写出具有出色情节、引人入胜的人物和意想不到的高潮的作品。我的第一个要求是“我要写一部以未来为背景的科幻小说”。', '我想让你扮演一个小说家。您将想出富有创意且引人入胜的故事，可以长期吸引读者。你可以选择任何类型，如奇幻、浪漫、历史小说等——但你的目标是写出具有出色情节、引人入胜的人物和意想不到的高潮的作品。我的第一个要求是“[PROMPT]”。', '提示：输入内容', '', 0, 0, 0, 0, 8555, 3551, 100, 1, 0, 1683618737, 1683618737),
(79, 131, NULL, 56, 0, '充当励志演讲者', '我希望你充当励志演说家。将能够激发行动的词语放在一起，让人们感到有能力做一些超出他们能力的事情。你可以谈论任何话题，但目的是确保你所说的话能引起听众的共鸣，激励他们努力实现自己的目标并争取更好的可能性。我的第一个请求是“我需要一个关于每个人如何永不放弃的演讲”。', '我希望你充当励志演说家。将能够激发行动的词语放在一起，让人们感到有能力做一些超出他们能力的事情。你可以谈论任何话题，但目的是确保你所说的话能引起听众的共鸣，激励他们努力实现自己的目标并争取更好的可能性。我的第一个请求是“[PROMPT]”。', '自定义', '', 0, 0, 0, 0, 5543, 1238, 100, 1, 0, 1683618780, 1683618780),
(80, 131, NULL, 57, 0, '作为招聘人员', '我想让你担任招聘人员。我将提供一些关于职位空缺的信息，而你的工作是制定寻找合格申请人的策略。这可能包括通过社交媒体、社交活动甚至参加招聘会接触潜在候选人，以便为每个职位找到最合适的人选。我的第一个请求是“我需要帮助改进我的简历。”', '我想让你担任招聘人员。我将提供一些关于职位空缺的信息，而你的工作是制定寻找合格申请人的策略。这可能包括通过社交媒体、社交活动甚至参加招聘会接触潜在候选人，以便为每个职位找到最合适的人选。我的第一个请求是“我需要帮助改进我的简历。”', '我想让你担任招聘人员。我将提供一些关于职位空缺的信息，而你的工作是制定寻找合格申请人的策略。这可能包括通过社交媒体、社交活动甚至参加招聘会接触潜在候选人，以便为每个职位找到最合适的人选。我的第一个请求是“我需要帮助改进我的简历。”', '', 0, 0, 0, 0, 5887, 1585, 100, 1, 0, 1683618827, 1683618827),
(81, 131, NULL, 58, 0, '担任牙医', '担任牙医', '我想让你扮演牙医。我将为您提供有关寻找牙科服务（例如 X 光、清洁和其他治疗）的个人的详细信息。您的职责是诊断他们可能遇到的任何潜在问题，并根据他们的情况建议最佳行动方案。您还应该教育他们如何正确刷牙和使用牙线，以及其他有助于在两次就诊之间保持牙齿健康的口腔护理方法。我的第一个请求是“[PROMPT]。”', '我想让你扮演牙医。我将为您提供有关寻找牙科服务（例如 X 光、清洁和其他治疗）的个人的详细信息。您的职责是诊断他们可能遇到的任何潜在问题，并根据他们的情况建议最佳行动方案。您还应该教育他们如何正确刷牙和使用牙线，以及其他有助于在两次就诊之间保持牙齿健康的口腔护理方法。我的第一个请求是“我需要帮助解决我对冷食的敏感问题。”', '', 0, 0, 0, 0, 4585, 1278, 100, 1, 0, 1683618897, 1683618897),
(82, 131, NULL, 58, 0, '充当 AI 辅助医生', '充当 AI 辅助医生', '我想让你扮演一名人工智能辅助医生。我将为您提供患者的详细信息，您的任务是使用最新的人工智能工具，例如医学成像软件和其他机器学习程序，以诊断最可能导致其症状的原因。您还应该将体检、实验室测试等传统方法纳入您的评估过程，以确保准确性。我的第一个请求是“[PROMPT]”。', '我想让你扮演一名人工智能辅助医生。我将为您提供患者的详细信息，您的任务是使用最新的人工智能工具，例如医学成像软件和其他机器学习程序，以诊断最可能导致其症状的原因。您还应该将体检、实验室测试等传统方法纳入您的评估过程，以确保准确性。我的第一个请求是“我需要帮助诊断一例严重的腹痛”。', '', 0, 0, 0, 0, 8555, 5455, 100, 1, 0, 1683618948, 1683618948),
(83, 131, NULL, 58, 0, '充当医生', '充当医生', '我想让你扮演医生的角色，想出创造性的治疗方法来治疗疾病。您应该能够推荐常规药物、草药和其他天然替代品。在提供建议时，您还需要考虑患者的年龄、生活方式和病史。我的第一个建议请求是“[PROMPT]”。', '我想让你扮演医生的角色，想出创造性的治疗方法来治疗疾病。您应该能够推荐常规药物、草药和其他天然替代品。在提供建议时，您还需要考虑患者的年龄、生活方式和病史。我的第一个建议请求是“为患有关节炎的老年患者提出一个侧重于整体治疗方法的治疗计划”。', '', 0, 0, 0, 0, 7556, 2531, 100, 1, 0, 1683619011, 1683619011),
(84, 131, NULL, 58, 0, '担任营养师', '担任营养师', '作为一名营养师，我想为 2 人设计一份素食食谱，每份含有大约 500 卡路里的热量并且血糖指数较低。你能提供一个建议吗？', '作为一名营养师，我想为 2 人设计一份素食食谱，每份含有大约 500 卡路里的热量并且血糖指数较低。你能提供一个建议吗？', '', 0, 0, 0, 0, 7555, 1239, 100, 1, 0, 1683619070, 1683619070),
(85, 131, NULL, 58, 0, '充当心理学家', '充当心理学家', '我想让你扮演一个心理学家。我会告诉你我的想法。我希望你能给我科学的建议，让我感觉更好。我的第一个想法，{ 在这里输入你的想法，如果你解释得更详细，我想你会得到更准确的答案。}[PROMPT]', '我想让你扮演一个心理学家。我会告诉你我的想法。我希望你能给我科学的建议，让我感觉更好。我的第一个想法，{ 在这里输入你的想法，如果你解释得更详细，我想你会得到更准确的答案。}', '', 0, 0, 0, 0, 5545, 4523, 100, 1, 0, 1683619193, 1683619193),
(86, 131, NULL, 58, 0, '充当美食评论家', '充当美食评论家', '我想让你扮演美食评论家。我会告诉你一家餐馆，你会提供对食物和服务的评论。您应该只回复您的评论，而不是其他任何内容。不要写解释。我的第一个请求是“我昨晚去了一家新的意大利餐厅。你能提供评论吗？”[PROMPT]', '我想让你扮演美食评论家。我会告诉你一家餐馆，你会提供对食物和服务的评论。您应该只回复您的评论，而不是其他任何内容。不要写解释。我的第一个请求是“我昨晚去了一家新的意大利餐厅。你能提供评论吗？”', '', 0, 0, 0, 0, 8544, 2265, 100, 1, 0, 1683619232, 1683619232),
(87, 131, NULL, 58, 0, '担任私人厨师', '担任私人厨师', '我要你做我的私人厨师。我会告诉你我的饮食偏好和过敏，你会建议我尝试的食谱。你应该只回复你推荐的食谱，别无其他。不要写解释。我的第一个请求是“我是一名素食主义者，我正在寻找健康的晚餐点子。”[PROMPT]', '我要你做我的私人厨师。我会告诉你我的饮食偏好和过敏，你会建议我尝试的食谱。你应该只回复你推荐的食谱，别无其他。不要写解释。我的第一个请求是“我是一名素食主义者，我正在寻找健康的晚餐点子。”', '', 0, 0, 0, 0, 8854, 1255, 100, 1, 0, 1683619277, 1683619277),
(88, 131, NULL, 58, 0, '担任法律顾问', '担任法律顾问', '我想让你做我的法律顾问。我将描述一种法律情况，您将就如何处理它提供建议。你应该只回复你的建议，而不是其他。不要写解释。我的第一个请求是“我出了车祸，不知道该怎么办”。[PROMPT]', '我想让你做我的法律顾问。我将描述一种法律情况，您将就如何处理它提供建议。你应该只回复你的建议，而不是其他。不要写解释。我的第一个请求是“我出了车祸，不知道该怎么办”。', '', 0, 0, 0, 0, 4568, 2653, 100, 1, 0, 1683619320, 1683619320),
(89, 136, NULL, 64, 0, '写一篇文章', '用你喜欢的语言写一篇关于任何主题的文章', '用[TARGETLANGGE]写一篇关于[PROMPT]的文章', '输入文章的主题，然后按发送键', '', 0, 8, 0, 24, 335, 102, 100, 1, 0, 1683638040, 1683638040),
(90, 136, NULL, 64, 0, '写一首诗', '用你喜欢的语言写一篇关于任何主题的诗篇', '用[TARGETLANGGE]写一篇关于[PROMPT]的诗篇', '输入诗篇的主题，然后按发送键', '', 0, 0, 0, 8, 88, 45, 100, 1, 0, 1683638142, 1683638142),
(91, 136, NULL, 64, 0, '写一篇演讲稿', '用你喜欢的语言写一篇关于任何主题的演讲稿', '用[TARGETLANGGE]写一篇关于[PROMPT]的演讲稿，需要有演讲稿的格式', '输入演讲稿的主题，然后按发送键', '', 0, 0, 0, 66, 88, 142, 100, 1, 0, 1683638266, 1683638266);

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_write_prompts_vote`
--

CREATE TABLE `fox_chatgpt_write_prompts_vote` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `prompt_id` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `fox_chatgpt_write_prompts_vote`
--

INSERT INTO `fox_chatgpt_write_prompts_vote` (`id`, `site_id`, `user_id`, `prompt_id`, `create_time`) VALUES
(3, 64, 4171, 13, 1679538735),
(4, 25, 12, 32, 1682395150),
(5, 128, 6189, 57, 1683082813);

-- --------------------------------------------------------

--
-- 表的结构 `fox_chatgpt_write_topic`
--

CREATE TABLE `fox_chatgpt_write_topic` (
  `id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `weight` int(11) DEFAULT '100' COMMENT '大的靠前',
  `state` tinyint(1) DEFAULT '1',
  `update_time` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `fox_chatgpt_write_topic`
--

INSERT INTO `fox_chatgpt_write_topic` (`id`, `site_id`, `title`, `weight`, `state`, `update_time`, `create_time`) VALUES
(1, 1, '文章创作', 100, 1, 1678323600, NULL),
(2, 1, '工作助手', 100, 1, 1678323600, NULL),
(3, 1, '生活助手', 100, 1, 1678323600, NULL),
(4, 1, '编程开发', 100, 1, 1678323600, NULL),
(5, 1, '其他应用', 100, 1, 1678323600, NULL);

--
-- 转储表的索引
--

--
-- 表的索引 `fox_chatgpt_article`
--
ALTER TABLE `fox_chatgpt_article`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_card`
--
ALTER TABLE `fox_chatgpt_card`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `fox_chatgpt_card_batch`
--
ALTER TABLE `fox_chatgpt_card_batch`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `fox_chatgpt_commission_apply`
--
ALTER TABLE `fox_chatgpt_commission_apply`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_commission_bill`
--
ALTER TABLE `fox_chatgpt_commission_bill`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_commission_withdraw`
--
ALTER TABLE `fox_chatgpt_commission_withdraw`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_cosplay_role`
--
ALTER TABLE `fox_chatgpt_cosplay_role`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `fox_chatgpt_cosplay_type`
--
ALTER TABLE `fox_chatgpt_cosplay_type`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `fox_chatgpt_draw`
--
ALTER TABLE `fox_chatgpt_draw`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_engine`
--
ALTER TABLE `fox_chatgpt_engine`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `fox_chatgpt_feedback`
--
ALTER TABLE `fox_chatgpt_feedback`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_goods`
--
ALTER TABLE `fox_chatgpt_goods`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_gpt4`
--
ALTER TABLE `fox_chatgpt_gpt4`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_keys`
--
ALTER TABLE `fox_chatgpt_keys`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `fox_chatgpt_logs`
--
ALTER TABLE `fox_chatgpt_logs`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_msg`
--
ALTER TABLE `fox_chatgpt_msg`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_msg_cosplay`
--
ALTER TABLE `fox_chatgpt_msg_cosplay`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `fox_chatgpt_msg_draw`
--
ALTER TABLE `fox_chatgpt_msg_draw`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_msg_group`
--
ALTER TABLE `fox_chatgpt_msg_group`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `fox_chatgpt_msg_web`
--
ALTER TABLE `fox_chatgpt_msg_web`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE,
  ADD KEY `group_id` (`group_id`) USING BTREE,
  ADD KEY `create_time` (`create_time`) USING BTREE;

--
-- 表的索引 `fox_chatgpt_msg_write`
--
ALTER TABLE `fox_chatgpt_msg_write`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `fox_chatgpt_order`
--
ALTER TABLE `fox_chatgpt_order`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_pclogin`
--
ALTER TABLE `fox_chatgpt_pclogin`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `fox_chatgpt_reward_ad`
--
ALTER TABLE `fox_chatgpt_reward_ad`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_reward_invite`
--
ALTER TABLE `fox_chatgpt_reward_invite`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_reward_share`
--
ALTER TABLE `fox_chatgpt_reward_share`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_setting`
--
ALTER TABLE `fox_chatgpt_setting`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_site`
--
ALTER TABLE `fox_chatgpt_site`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_super`
--
ALTER TABLE `fox_chatgpt_super`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_user`
--
ALTER TABLE `fox_chatgpt_user`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_user_balance_draw_logs`
--
ALTER TABLE `fox_chatgpt_user_balance_draw_logs`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_user_balance_gpt4_logs`
--
ALTER TABLE `fox_chatgpt_user_balance_gpt4_logs`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_user_balance_logs`
--
ALTER TABLE `fox_chatgpt_user_balance_logs`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_user_vip_logs`
--
ALTER TABLE `fox_chatgpt_user_vip_logs`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `fox_chatgpt_vip`
--
ALTER TABLE `fox_chatgpt_vip`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `fox_chatgpt_write_prompts`
--
ALTER TABLE `fox_chatgpt_write_prompts`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `fox_chatgpt_write_prompts_vote`
--
ALTER TABLE `fox_chatgpt_write_prompts_vote`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `fox_chatgpt_write_topic`
--
ALTER TABLE `fox_chatgpt_write_topic`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_article`
--
ALTER TABLE `fox_chatgpt_article`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_card`
--
ALTER TABLE `fox_chatgpt_card`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_card_batch`
--
ALTER TABLE `fox_chatgpt_card_batch`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_commission_apply`
--
ALTER TABLE `fox_chatgpt_commission_apply`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_commission_bill`
--
ALTER TABLE `fox_chatgpt_commission_bill`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_commission_withdraw`
--
ALTER TABLE `fox_chatgpt_commission_withdraw`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_cosplay_role`
--
ALTER TABLE `fox_chatgpt_cosplay_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_cosplay_type`
--
ALTER TABLE `fox_chatgpt_cosplay_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_draw`
--
ALTER TABLE `fox_chatgpt_draw`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_engine`
--
ALTER TABLE `fox_chatgpt_engine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_feedback`
--
ALTER TABLE `fox_chatgpt_feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_goods`
--
ALTER TABLE `fox_chatgpt_goods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_gpt4`
--
ALTER TABLE `fox_chatgpt_gpt4`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_keys`
--
ALTER TABLE `fox_chatgpt_keys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_logs`
--
ALTER TABLE `fox_chatgpt_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_msg`
--
ALTER TABLE `fox_chatgpt_msg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_msg_cosplay`
--
ALTER TABLE `fox_chatgpt_msg_cosplay`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_msg_draw`
--
ALTER TABLE `fox_chatgpt_msg_draw`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_msg_group`
--
ALTER TABLE `fox_chatgpt_msg_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_msg_web`
--
ALTER TABLE `fox_chatgpt_msg_web`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_msg_write`
--
ALTER TABLE `fox_chatgpt_msg_write`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_order`
--
ALTER TABLE `fox_chatgpt_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_pclogin`
--
ALTER TABLE `fox_chatgpt_pclogin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_reward_ad`
--
ALTER TABLE `fox_chatgpt_reward_ad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_reward_invite`
--
ALTER TABLE `fox_chatgpt_reward_invite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_reward_share`
--
ALTER TABLE `fox_chatgpt_reward_share`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_setting`
--
ALTER TABLE `fox_chatgpt_setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_site`
--
ALTER TABLE `fox_chatgpt_site`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_super`
--
ALTER TABLE `fox_chatgpt_super`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_user`
--
ALTER TABLE `fox_chatgpt_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_user_balance_draw_logs`
--
ALTER TABLE `fox_chatgpt_user_balance_draw_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_user_balance_gpt4_logs`
--
ALTER TABLE `fox_chatgpt_user_balance_gpt4_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_user_balance_logs`
--
ALTER TABLE `fox_chatgpt_user_balance_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_user_vip_logs`
--
ALTER TABLE `fox_chatgpt_user_vip_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_vip`
--
ALTER TABLE `fox_chatgpt_vip`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_write_prompts`
--
ALTER TABLE `fox_chatgpt_write_prompts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_write_prompts_vote`
--
ALTER TABLE `fox_chatgpt_write_prompts_vote`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用表AUTO_INCREMENT `fox_chatgpt_write_topic`
--
ALTER TABLE `fox_chatgpt_write_topic`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
